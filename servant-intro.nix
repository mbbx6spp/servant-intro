{ mkDerivation, aeson, base, Cabal, cabal-doctest, network-simple
, optparse-generic, protolude, servant, servant-client
, servant-ruby, servant-server, servant-swagger, stdenv, text, time
, wai, wai-logger, warp
}:
mkDerivation {
  pname = "servant-intro";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  setupHaskellDepends = [ base Cabal cabal-doctest ];
  executableHaskellDepends = [
    aeson base network-simple optparse-generic protolude servant
    servant-client servant-ruby servant-server servant-swagger text
    time wai wai-logger warp
  ];
  homepage = "https://github.com/mbbx6spp/servant-intro";
  description = "Intro to Servant concepts for (re)training Ruby/Rail or Ruby/Sinatra web apps with";
  license = stdenv.lib.licenses.asl20;
}
