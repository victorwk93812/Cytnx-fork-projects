{pkgs ? import <nixpkgs> {} }: 
pkgs.mkShell {
    # Using packages instead of buildInputs is also fine
    buildInputs = with pkgs; [ 
        # nixpkgs-fmt
        gnumake
        cmake
        doctest
        boost
        openblas
        llvmPackages_18.openmp
        graphviz
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
# select Python packages here
            numpy
            scipy
            # pandas
            # pyqt5
            # pyqt6
            matplotlib
            # uncertainties
            venvShellHook
            pybind11
            pygraphviz
            beartype
        ]))
        mkl
   ];

    shellHook = ''
        cmake --version
    ''; 
}
