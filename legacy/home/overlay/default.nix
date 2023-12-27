{ rubyPackagePath }:
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
in {
  inherit python311-withPandasAccommodations;

  joshua = rec {
    cc2538-bsl = prev.cc2538-bsl.override { python3Packages = python311.pkgs; };

    python311 = prev.python311.withPackages (ps: with ps; [
      black

      mypy
      pylint

      python-lsp-server
      python-lsp-black
      pylsp-mypy
      pynvim

      pandas
      # pandas-stubs

      typing-extensions

      pyserial intelhex
    ]);

    ruby31 = prev.callPackage rubyPackagePath {};
  };
}
