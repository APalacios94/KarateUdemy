function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail= 'karatetester1996@test.com'
    config.userPassword= 'karatetester'
  } 
  if (env == 'e2e') {
    config.userEmail= 'karate2@test.com'
    config.userPassword= 'Karate456'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken}) 


  return config;
}