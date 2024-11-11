# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			inputs.home-manager.nixosModules.default
		];
		

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.supportedFilesystems = [ "ntfs" ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Asia/Kolkata";
	time.hardwareClockInLocalTime = true;

	services.ntp.enable = true;

	# Select internationalisation properties.
	i18n.supportedLocales = [ "all" ];
	i18n.defaultLocale = "en_IN.UTF-8";

	# i18n.extraLocaleSettings = {
	# 	LC_ADDRESS = "en_IN";
	# 	LC_IDENTIFICATION = "en_IN";
	# 	LC_MEASUREMENT = "en_IN";
	# 	LC_MONETARY = "en_IN";
	# 	LC_NAME = "en_IN";
	# 	LC_NUMERIC = "en_IN";
	# 	LC_PAPER = "en_IN";
	# 	LC_TELEPHONE = "en_IN";
	# 	LC_TIME = "en_IN";
	# };

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" ]; })
	];

	# Pipewire
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	systemd.services.cpupower = {
		wantedBy = [ "multi-user.target" ];
		enable = true;
		serviceConfig = {
			ExecStart = "${pkgs.linuxKernel.packages.linux_6_6.cpupower}/bin/cpupower frequency-set --governor powersave";
		};
	};

	# Laptop
	services.power-profiles-daemon.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.amitk = {
		isNormalUser = true;
		description = "Amit Kumar";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	# Nautilus
	services.gvfs.enable = true;

	programs.dconf = {
		enable = true;
	};

	programs.zsh.enable = true;

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	# Hyprland
	programs.hyprland = {
		enable = true;
	};

	#xdg.portal = {
	#  enable = true;
	#  xdgOpenUsePortal = true;
	#};

	xdg.mime = {
		enable = true;
		defaultApplications = {
			"text/markdown" = [ "org.gnome.TextEditor.desktop" ];
		};
	};

	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	environment.variables = {
	};

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; 
	[
			linuxKernel.packages.linux_6_6.cpupower
			adw-gtk3
			adwaita-icon-theme
			ags
			blender-hip
			brave
			brightnessctl
			cliphist
			dconf-editor
			entr
			file
			fzf
			gnome-text-editor
			gnome-disk-utility
			gh
			git
			godot_4
			grim
			hyprlock
			jq
			kitty
			nautilus
			nwg-drawer
			nwg-look
			oh-my-posh
			slurp
			stow
			ttyper
			waybar
			wl-clipboard
			wofi
			xdg-utils
			yazi
			zig
			zoxide
			zsh
			# lsp server
			nil
			typescript
			nodePackages.typescript-language-server
			];

	environment.variables.EDITOR="nvim";
	users.defaultUserShell = pkgs.zsh;
	

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"amitk" = import ./home.nix;
		};
	};

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };


	# List services that you want to enable:
	services.flatpak.enable = true;

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
