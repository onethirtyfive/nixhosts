final: prev:
let
  python311-withPandasAccommodations = prev.python311.override {
    packageOverrides = pyself: pysuper: {
      pylsp-mypy = pysuper.pylsp-mypy.overridePythonAttrs (_: {
        doCheck = false;
      });

      tensorboard-data-server = pysuper.tensorboard-data-server.overridePythonAttrs (super: rec {
        version = "0.7.0";
        disabled = pysuper.pythonOlder "3.7";
        src = pysuper.fetchPypi {
          pname = "tensorboard_data_server";
          inherit version;
          inherit (super) format;
          dist = "py3";
          python = "py3";
          hash = "sha256-dT1CFHmbMdp7bZODeVmr67xq+obmnqzx6aMXpI2qMes=";
        };
        dontCheck = true;
      });

      tensorboard = pysuper.tensorboard.overridePythonAttrs (super: rec {
        version = "2.13.0";
        disabled = pysuper.pythonOlder "3.7";
        src = pysuper.fetchPypi {
          inherit version;
          inherit (super) pname format;
          dist = "py3";
          python = "py3";
          sha256 = "sha256-q2mWHr3b3cg/X6L/kjNXK9rVuIN3jDXk/pS/F5i9hIE=";
        };
        dontCheck = true;
      });
    };
  };

  basis-ruby_3_1 = prev.ruby_3_1;

  standardrb = prev.buildRubyGem rec {
    name = "standard-${version}";
    ruby = basis-ruby_3_1;
    gemName = "standard";
    version = "1.30.1";
    source = {
      sha256="dd4378691541af8a416bdf78afa99b7cf0186833291bdffd16745af959f1c834";
    };
  };
in {
  inherit python311-withPandasAccommodations;

  joshua = rec {
    cc2538-bsl = prev.cc2538-bsl.override { python3Packages = python311.pkgs; };

    python311 = python311-withPandasAccommodations.withPackages (ps: with ps; [
      black

      mypy
      pylint

      python-lsp-server
      python-lsp-black
      pylsp-mypy
      pynvim

      pandas
      pandas-stubs

      typing-extensions

      pyserial intelhex
    ]);

    ruby_3_1 = basis-ruby_3_1.withPackages (ps: with ps; [
      solargraph
      standardrb
    ]);
  };
}
