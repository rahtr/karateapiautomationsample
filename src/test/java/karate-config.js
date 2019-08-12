function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  var baseurl = karate.properties['baseurl'];
  if (!env) {
    env = 'dev';
  }
  if (env == 'dev') {
  //baseurl='https://api-dev.paycor.com/hcmcore'
  baseurl = 'https://localhost'
  } else if (env == 'e2e') {
    // customize
  }
    var config = {
      env: env,
  	baseurl: baseurl
    }
  config.BaseUrl=baseurl
  return config;
}