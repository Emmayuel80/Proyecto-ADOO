var nodemailer = require('nodemailer');

var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'enigmalibro@gmail.com',
    pass: 'adoescom2019'
  }
});

var mailOptions = {
  from: 'enigmalibro@gmail.com',
  to: 'sza0210escom@gmail.com, emmayuel80@gmail.com',
  subject: 'Sending Email using Node.js',
  text: `The game`

};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
});
