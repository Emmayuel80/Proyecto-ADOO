// config/passport.js

// load all the things we need
var LocalStrategy = require('passport-local').Strategy;

var mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root'
});

connection.query('USE libreria');

// expose this function to our app using module.exports
module.exports = function(passport) {

    // =========================================================================
    // passport session setup ==================================================
    // =========================================================================
    // required for persistent login sessions
    // passport needs ability to serialize and unserialize users out of session

    // used to serialize the user for the session
    passport.serializeUser(function(user, done) {
        done(null, user.idCliente);
    });

    // used to deserialize the user
    passport.deserializeUser(function(id, done) {
        connection.query("select * from cliente where idCliente = " + id, function(err, rows) {
            return done(err, rows[0]);
        });
    });


    // =========================================================================
    // LOCAL SIGNUP ============================================================
    // =========================================================================
    // we are using named strategies since we have one for login and one for signup
    // by default, if there was no name, it would just be called 'local'

    passport.use('local-signup', new LocalStrategy({
            // by default, local strategy uses username and password, we will override with email
            usernameField: 'email',
            passwordField: 'password',
            passReqToCallback: true // allows us to pass back the entire request to the callback
        },
        function(req, email, password, done) {
            var lastId;
            //Obtaining the last id
            connection.query("select idCliente from cliente order by idCliente DESC", function(err, rows) {
                lastId = Number(rows[0].idCliente);
            });
            // find a user whose email is the same as the forms email
            // we are checking to see if the user trying to login already exists
            connection.query("select * from cliente where email = '" + email + "'", function(err, rows) {
                console.log(rows);
                console.log("above row object");
                if (err)
                    return done(err);
                if (rows.length) {
                    return done(null, false, req.flash('signupMessage', 'Esa dirección de correo electronico ya existe.'));
                } else {

                    // if there is no user with that email
                    // create the user
                    var newUserMysql = {
                        idCliente: parseInt((lastId + 1)),
                        Genero: req.body.generos,
                        Nombre: req.body.name,
                        ap: req.body.apPaterno,
                        am: req.body.apMaterno,
                        dir: req.body.Estado,
                        calle: req.body.calle,
                        colonia: req.body.colonia,
                        CP: parseInt(req.body.cp),
                        num: parseInt(req.body.num),
                        Tel: req.body.tel,
                        email: req.body.email,
                        contraseña: password, // use the generateHash function in our user model
                    }

                    var insertQuery = "INSERT INTO Cliente SET ?";
                    console.log(insertQuery);
                    connection.query(insertQuery, newUserMysql, function(err, rows) {
                        //newUserMysql.idCliente = rows.insertId;

                        return done(null, newUserMysql);
                    });
                }
            });
        }));

    // =========================================================================
    // LOCAL LOGIN =============================================================
    // =========================================================================
    // we are using named strategies since we have one for login and one for signup
    // by default, if there was no name, it would just be called 'local'

    passport.use('local-login', new LocalStrategy({
            // by default, local strategy uses username and password, we will override with email
            usernameField: 'email',
            passwordField: 'password',
            passReqToCallback: true // allows us to pass back the entire request to the callback
        },
        function(req, email, password, done) { // callback with email and password from our form
          console.log("????",req.params.lib);
            connection.query("SELECT * FROM `cliente` WHERE `email` = '" + email + "'", function(err, rows) {
                if (err)
                    return done(err);
                if (!rows.length) {
                    return done(null, false, req.flash('loginMessage', 'Esa direccion de correo electronico no esta registrada.')); // req.flash is the way to set flashdata using connect-flash
                }

                // if the user is found but the password is wrong
                if (!(rows[0].contraseña == password))
                    return done(null, false, req.flash('loginMessage', 'Oops! Contraseña incorrecta.')); // create the loginMessage and save it to session as flashdata

                // all is well, return successful user
                return done(null, rows[0],req.flash('loginMessage',req.params.lib));

            });



        }));



};
