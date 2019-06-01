// app/routes.js
var fs = require('fs');
module.exports = function (app, passport) {

  var mysql = require('mysql');
  var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root'
  });
  connection.connect(function (error) {
    if (!!error) {
      console.log(error);
    } else {
      console.log('Connected!:)');
    }
  });
  connection.query('USE libreria');
  // =====================================
  // HOME PAGE (with login links) ========
  // =====================================
  app.get('/', function (req, res) {
    if (req.isAuthenticated()) {
      var style = '';
      var style2 = 'style=display:none;  ';
      var da = req.user.Nombre;
      var ap = req.user.ap;
      var id = req.user.idCliente;
      var num;
      console.log(id);
      connection.query('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id), (err, cant) => {
        //console.log('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id));
        // console.log("carr",typeof(cant[0].total),cant[0].total);
        if (err) {
          res.json(err);
        }

        if (cant[0].total && cant[0].total !== "null" && cant[0].total !== "undefined") {
          num = cant[0].total;
        }
        else {
          num = 0;
        }
        console.log("nn", num);
        res.render('index.ejs', {
          user: style,
          as: style2,
          dato1: da,
          dato2: ap,
          dato3: num
        }); // load the index.ejs file
      });
    } else {

      var style = 'style=display:none;  ';
      var style2 = '';
      var da = '';
      var ap = '';
      num = 0;
      res.render('index.ejs', {
        user: style,
        as: style2,
        dato1: da,
        dato2: ap,
        dato3: num
      }); // load the index.ejs file
    }
    console.log(num);

  });

  // =====================================
  // LOGIN ===============================
  // =====================================
  // show the login form
  app.get('/login', function (req, res) {
    var ori = "";
    // render the page and pass in any flash data if it exists
    res.render('login.ejs', { message: req.flash('loginMessage'), origen: ori });
  });

  app.get('/login/libro/:lib', function (req, res) {
    var ori = "/libro/".concat(req.params.lib);
    // render the page and pass in any flash data if it exists
    res.render('login.ejs', { message: "Tienes que iniciar sesión", origen: ori });
  });
  // process the login form
  // app.post('/login', do all our passport stuff here);

  // =====================================
  // SIGNUP ==============================
  // =====================================
  // show the signup form
  app.get('/signup', function (req, res) {

    // render the page and pass in any flash data if it exists
    res.render('signup.ejs', { message: req.flash('signupMessage') });
  });


  app.get('/registro', function (req, res) {

    // render the page and pass in any flash data if it exists
    res.render('registro.ejs', { message: req.flash('signupMessage') });
  });

  // =====================================
  // carrito ========
  // =====================================
  app.get('/cart', isLoggedIn, function (req, res) {
    var f = req.user;

    var id = f.idCliente;
    console.log(id);
    connection.query('SELECT c.*,t.titulo FROM carrito c,libro t WHERE c.cliente = ? and c.libro=t.NumSerie', id, (err, datos) => {
      if (err) {
        res.json(err);
      }
      console.log(datos);
      var style = '';
      var style2 = 'style=display:none;  ';
      var da = req.user.Nombre;
      var ap = req.user.ap;
      var id = req.user.idCliente;
      var num;
      connection.query('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id), (err, cant) => {

        if (err) {
          res.json(err);
        }
        if (cant[0].total && cant[0].total !== "null" && cant[0].total !== "undefined") {
          num = cant[0].total;
        }
        else {
          num = 0;
        }
        res.render('cart', {
          data: datos,
          user: style,
          as: style2,
          dato1: da,
          dato2: ap,
          dato3: num
        });

      });

    });
  });

  app.get('/cart/delete/:lib', isLoggedIn, function (req, res) {
    var cli = req.user.idCliente;
    var lib = req.params.lib;
    var sen = "DELETE FROM carrito WHERE cliente="
    var pe = sen.concat(cli, " and libro=", lib)
    console.log(pe);
    connection.query(pe, (err, datos) => {
      if (err) {
        res.json(err);
      }
      console.log(datos);
      res.redirect('/cart');
    });
  });

  app.post('/cart/update/:bo/:x', isLoggedIn, function (req, res) {
    var n = req.params.x;
    var cli = req.user.idCliente;
    var l = req.params.bo;
    console.log(req.params);
    var pet = 'UPDATE carrito set cantidad='.concat(l, " where ( cliente=", cli, " and libro=", n, ")")
    console.log(pet);
    connection.query(pet, (err, rows) => {

      res.redirect('/cart');
    });


  });




  app.get('/resultados', function (req, res) {
    res.render('resultados'); // load the index.ejs file
  });

  app.post('/resultados', function (req, res) {

    var cat = req.body.filtro;
    var book = req.body.cosa.trim();
    var sen = "select  l.*, a.Autor from libro l, libaut a where  ";
    var pe = sen.concat(cat, " like '%", book, "%' and a.NumSerie=l.NumSerie order by l.NumSerie");


    console.log(pe);

    connection.query(pe, (err, datos) => {
      var result = [];
      if (err) {
        res.json(err);
      }

      resultArray = Object.values(JSON.parse(JSON.stringify(datos)));
      var porta = [];
      console.log(resultArray.length);
      for (var i = 0; i < resultArray.length; i++) {
        if (result.length > 0) {
          if (resultArray[i - 1].NumSerie == resultArray[i].NumSerie) {
            var aut = resultArray[i - 1].Autor;
            //console.log(aut);
            resultArray[i - 1].Autor = aut.concat(", ", resultArray[i].Autor)
          }
          else {
            result.push(resultArray[i]);
          }
        }
        else {
          result.push(resultArray[i]);
        }
        //console.log(i, result);
      }
      //console.log("fin", result);
      for (var x = 0; x < result.length; x++) {
        try {
          fs.statSync('./assets/portadas/p_'.concat(result[x].NumSerie, '.jpg'));
          porta.push("portadas/p_".concat(result[x].NumSerie, '.jpg'));
        }
        catch (err) {
          if (err.code === 'ENOENT') {
            porta.push("book.png");
          }
        }



      }
      console.log(porta);

      if (req.isAuthenticated()) {
        var style = '';
        var style2 = 'style=display:none;  ';
        var da = req.user.Nombre;
        var ap = req.user.ap;
        var id = req.user.idCliente;
        var num;
        connection.query('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id), (err, cant) => {

          if (err) {
            res.json(err);
          }
          if (cant[0].total && cant[0].total !== "null" && cant[0].total !== "undefined") {
            num = cant[0].total;
          }
          else {
            num = 0;
          }
          res.render('resultados', {
            data: result,
            portada: porta,
            user: style,
            as: style2,
            dato1: da,
            dato2: ap,
            dato3: num
          });

        });

      } else {

        var style = 'style=display:none;  ';
        var style2 = '';
        var da = '';
        var ap = '';
        num = 0;
        res.render('resultados', {
          data: result,
          portada: porta,
          user: style,
          as: style2,
          dato1: da,
          dato2: ap,
          dato3: num

        });
      }




    });
    //console.log("xdddd",typeof(resultArray));
  });

  app.get('/libro/:libb', function (req, res) {




   var men='';
    const  idb = req.params.libb;
    var sen = "select  l.*, a.Autor from libro l, libaut a where  l.NumSerie =";
    var pe = sen.concat(idb, ' and a.NumSerie=l.NumSerie');

    console.log(idb);
    connection.query(pe, (err, datos) => {

      if (err) {
        res.json(err);
      }
console.log("gg",datos,"id",idb);
      resultArray = Object.values(JSON.parse(JSON.stringify(datos)));
      var porta = [];

      if (resultArray.length > 1) {
        var result = resultArray[0].Autor;

        for (var n = 1; n < resultArray.length; n++) {
          result = result.concat(", ", resultArray[n].Autor);

        }
      }
      else {
        var result = resultArray[0].Autor;
      }

      try {
        fs.statSync('./assets/portadas/p_'.concat(idb, '.jpg'));
        var porta = "../../portadas/p_".concat(idb, '.jpg');
      }
      catch (err) {
        if (err.code === 'ENOENT') {
          var porta = "../../book.png";
        }
      }
      console.log('./assets/portadas/p_'.concat(idb, '.jpg'), "pop", porta);
      if (req.isAuthenticated()) {
        var style = '';
        var style2 = 'style=display:none;  ';
        var da = req.user.Nombre;
        var ap = req.user.ap;
        var id2 = req.user.idCliente;
        var num;
        connection.query('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id2), (err, cant) => {

          if (err) {
            res.json(err);
          }
          if (cant[0].total && cant[0].total !== "null" && cant[0].total !== "undefined") {
            num = cant[0].total;
          }
          else {
            num = 0;
          }
          res.render('libro', {
            data: datos,
            autor: result,
            portada: porta,
            user: style,
            as: style2,
            dato1: da,
            dato2: ap,
            dato3: num,
            mensaje: men
          });

        });

      } else {

        var style = 'style=display:none;  ';
        var style2 = '';
        var da = '';
        var ap = '';
        num = 0;
        res.render('libro', {
          data: datos,
          autor: result,
          portada: porta,
          user: style,
          as: style2,
          dato1: da,
          dato2: ap,
          dato3: num,
          mensaje:men
        });
      }

    });
  });



  app.post('/cart/:libro/:pre', function (req, res) {
    if (req.isAuthenticated()) {
      var f = req.params;

      var lib = req.params.libro;
      var pr = req.params.pre;
      var cli = req.user.idCliente;
      var sen = "INSERT INTO carrito() values("
      var pe = sen.concat(cli, ",", lib, ",", req.body.contador, ",", pr, ")");
      console.log(pe);
      connection.query('SELECT * FROM carrito WHERE cliente ='.concat(cli, " and libro=", lib), (err, val) => {

        console.log('SELECT * FROM carrito WHERE cliente ='.concat(cli, " and libro=", lib));
        console.log(val.length);
        if (val.length == 1) {

          var dir = '/libro/';
          req.flash('msg', 'El libro ya esta en tu carrito');
          res.redirect(dir.concat(lib));
        } else {
          connection.query(pe, (err, datos) => {
            if (err) {
              res.json(err);
            }
            var dir = '/libro/';
            req.flash('msg', 'Se añadio a tu carrito');
            res.redirect(dir.concat(lib));
          });
        }
      });
    } else {
      var lib = req.params.libro;
      res.redirect('/login/libro/'.concat(lib));
    }


    //res.render('/libro')
    // res.redirect('/');


  });
  // =====================================
  // PROFILE SECTION =====================
  // =====================================
  // we will want this protected so you have to be logged in to visit
  // we will use route middleware to verify this (the isLoggedIn function)
  app.get('/profile', isLoggedIn, function (req, res) {
    //res.render('profile.ejs', {
    //  user: req.user // get the user out of session and pass to template
    //  });
    var message = req.flash('loginMessage')
    console.log("lol", message);
    if (message.length == 0) {
      res.redirect('/');
    } else {
      res.redirect('/libro/'.concat(message));
    }

  });

  // =====================================
  // LOGOUT ==============================
  // =====================================
  app.get('/logout', function (req, res) {
    req.logout();
    res.redirect('/');
  });

  // process the signup form
  app.post('/registro', passport.authenticate('local-signup', {
    successRedirect: '/profile', // redirect to the secure profile section
    failureRedirect: '/registro', // redirect back to the signup page if there is an error
    failureFlash: true // allow flash messages
  }));

  // process the login form
  app.post('/login', passport.authenticate('local-login', {
    successRedirect: '/profile', // redirect to the secure profile section
    failureRedirect: '/login', // redirect back to the signup page if there is an error
    failureFlash: true // allow flash messages
  }));

  app.post('/login/libro/:lib', passport.authenticate('local-login', {
    successRedirect: '/profile', // redirect to the secure profile section
    failureRedirect: '/login', // redirect back to the signup page if there is an error
    failureFlash: true // allow flash messages
  }));

  function hola(p) {
    connection.query("SELECT Autor from libaut where NumSerie=653121", (err, autor) => {
      //console.log(autor);
      //console.log("xd");
      return autor;
    });
  }

  function hola2() {
    console.log("hola");
    connection.query("SELECT Autor from libaut where NumSerie=653121", (err, autor) => {
      // console.log(autor);
      //  console.log("xd");
      return autor;
    });

  }



};

// route middleware to make sure a user is logged in
function isLoggedIn(req, res, next) {

  // if user is authenticated in the session, carry on
  if (req.isAuthenticated())
    return next();

  // if they aren't redirect them to the home page
  res.redirect('/login');
}
