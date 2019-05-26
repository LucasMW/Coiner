let project = new Project('Coiner');
project.addAssets('Assets/**');
project.addShaders('Shaders/**');
project.addSources('Sources');
project.addLibrary('zui');

//ios
// project.targetOptions.ios.bundle = 'com.example.$(PRODUCT_NAME:rfc1034identifier)';
// project.targetOptions.ios.organizationName = 'Your Awesome Organization';
// project.targetOptions.ios.developmentTeam = 'XXXXXXXXXX';
// project.targetOptions.ios.version = '1.0';
// project.targetOptions.ios.build = '1';

//android 
// project.targetOptions.android.package = 'com.example.app';
// project.targetOptions.android.screenOrientation = 'portrait';
// project.targetOptions.android.permissions = ['android.permission.INTERNET'];
// project.targetOptions.android.installLocation = "auto";

resolve(project);


