// app/routes.js
module.exports = function(app, passport) {

  var mysql=require('mysql');
  var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root'
});
 connection.connect(function(error){
    if(!!error){
      console.log(error);
    }else{
      console.log('Connected!:)');
    }
  });
  connection.query('USE libreria');
    // =====================================
    // HOME PAGE (with login links) ========
    // =====================================
    app.get('/', function(req, res) {
        res.render('index.ejs'); // load the index.ejs file
    });

    // =====================================
    // LOGIN ===============================
    // =====================================
    // show the login form
    app.get('/login', function(req, res) {

        // render the page and pass in any flash data if it exists
        res.render('login.ejs', { message: req.flash('loginMessage') });
    });

    // process the login form
    // app.post('/login', do all our passport stuff here);

    // =====================================
    // SIGNUP ==============================
    // =====================================
    // show the signup form
    app.get('/signup', function(req, res) {

        // render the page and pass in any flash data if it exists
        res.render('signup.ejs', { message: req.flash('signupMessage') });
    });

    app.get('/registro', function(req, res) {

        // render the page and pass in any flash data if it exists
        res.render('registro.ejs', { message: req.flash('signupMessage') });
    });

     // =====================================
    // carrito ========
    // =====================================
    app.get('/cart', isLoggedIn,function(req, res) {
      var f = req.user;

      const id=f.idCliente;
      console.log(id);
      connection.query('SELECT * FROM carrito WHERE cliente = ?',id,(err, datos) => {
        if (err) {
         res.json(err);
        }
        console.log(datos);
        res.render('cart', {
           data: datos
        });
       });
  });

  app.get('/resultados', function(req, res) {
    res.render('resultados'); // load the index.ejs file
});
    // =====================================
    // PROFILE SECTION =====================
    // =====================================
    // we will want this protected so you have to be logged in to visit
    // we will use route middleware to verify this (the isLoggedIn function)
    app.get('/profile', isLoggedIn, function(req, res) {
        res.render('profile.ejs', {
            user: req.user // get the user out of session and pass to template
        });
    });

    // =====================================
    // LOGOUT ==============================
    // =====================================
    app.get('/logout', function(req, res) {
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
    res.redirect('/');
}
