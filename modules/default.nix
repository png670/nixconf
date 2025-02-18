{
  imports =
    [ # Include the results of the hardware scan.
        ./utilities.nix
	./multimedia.nix
	./games.nix
        ./development.nix
	./unfree-merger.nix
	./dwm.nix
    ];


}
