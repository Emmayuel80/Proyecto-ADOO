// app/routes.js
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
    if (req.isAuthenticated())
    {
      var style='';
      var style2='style=display:none;  ';
      var da=req.user.Nombre;
      var ap=req.user.ap;
      var id=req.user.idCliente;

      console.log(id);
      connection.query('SELECT SUM(cantidad) as total FROM carrito WHERE cliente = '.concat(id), (err, cant) => {

        if (err) {
          res.json(err);
        }
        res.render('index.ejs',
        {
          user:style,
          as:style2,
          dato1:da,
          dato2:ap,
          dato3:cant[0].total
        }); // load the index.ejs file
      });
    }
    else
    {

      var style='style=display:none;  ';
      var style2='';
      var da='';
      var ap='';
      var num=0;
      res.render('index.ejs',
      {
        user:style,
        as:style2,
        dato1:da,
        dato2:ap,
        dato3:num
      }); // load the index.ejs file
    }
    console.log(num);

  });

  // =====================================
  // LOGIN ===============================
  // =====================================
  // show the login form
  app.get('/login', function (req, res) {

    // render the page and pass in any flash data if it exists
    res.render('login.ejs', { message: req.flash('loginMessage') });
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
    connection.query('SELECT * FROM carrito WHERE cliente = ?', id, (err, datos) => {
      if (err) {
        res.json(err);
      }
      console.log(datos);
      res.render('cart', {
        data: datos
      });
    });
  });

  app.get('/cart/delete/:lib', isLoggedIn, function (req, res) {
    var cli = req.user.idCliente;
    var lib = req.params.lib;
    var sen="DELETE FROM carrito WHERE cliente="
    var pe=sen.concat(cli," and libro=",lib)
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
    var n=req.body.contador_x;
    var cli=req.user.idCliente;
    var l=req.params.bo;
    console.log(req.params);
    var pet='UPDATE carrito set cantidad='.concat(n," where ( cliente=",cli, " and libro=",l,")")
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
    var book = req.body.cosa;
    var sen = "SELECT * FROM libro WHERE ";
    var pe = sen.concat(cat, " like '%", book, "%'");
    console.log(pe);

    connection.query(pe, (err, datos) => {
      if (err) {
        res.json(err);
      }

      console.log(datos);
      res.render('resultados', {
        data: datos
      });
    });

  });

  app.get('/libro/:id', function (req, res) {
    const { id } = req.params;
      console.log(id);
      connection.query('SELECT * FROM libro WHERE NumSerie = ?', id, (err, datos) => {
        if (err) {
          res.json(err);
        }
        console.log(datos);
        res.render('libro', {
          data: datos
        });
      });
  });

  app.post('/cart/:libro/:pre',isLoggedIn, function (req, res) {
    var f = req.params;


    var lib = req.params.libro;
    var pr=req.params.pre;
    var cli = req.user.idCliente;
    var sen = "INSERT INTO carrito() values("
    var pe = sen.concat(cli,",", lib,",",req.body.contador,",",pr,")");
    console.log(pe);
    connection.query(pe, (err, datos) => {
      if (err) {
        res.json(err);
      }
      var dir='/libro/';
      res.redirect(dir.concat(lib));
    });


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
  res.redirect('/');
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


};

// route middleware to make sure a user is logged in
function isLoggedIn(req, res, next) {

  // if user is authenticated in the session, carry on
  if (req.isAuthenticated())
    return next();

  // if they aren't redirect them to the home page
  res.redirect('/login');
}
