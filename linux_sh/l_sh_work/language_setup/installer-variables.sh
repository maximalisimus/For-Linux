######################################################################
##                                                                  ##
##                   Installer Variables                            ##
##                                                                  ##
######################################################################

# Installation
_mlpcrm=0                   # Once check the pacman-contrib at the rom system to uses in the rankmirror script 
KDE_INSTALLED=0             # Has KDE been installed? Used for display manager option
GNOME_INSTALLED=0           # Has Gnome been installed? Used for display manager option
LXDE_INSTALLED=0            # Has LXDE been installed? Used for display manager option
LXQT_INSTALLED=0            # Has LXQT been installed? Used for display manager option
DM_INSTALLED=0              # Has a display manager been installed?
COMMON_INSTALLED=0          # Has the common-packages option been taken?
NM_INSTALLED=0              # Has a network connection manager been installed and enabled?
AXI_INSTALLED=0             # Have the ALSA, Xorg, and xf86-input packages been installed?
BOOTLOADER="n/a"            # Which bootloader has been installed?
EVOBOXFM=""                 # Which file manager has been selected for EvoBox?
EVOBOXIB=""                 # Which Internet Browser has been selected for EvoBox?
DM="n/a"                    # Which display manager has been installed?
KEYMAP="us"                 # Virtual console keymap. Default is "us"
XKBMAP="us"                 # X11 keyboard layout. Default is "us"
ZONE=""                     # For time
SUBZONE=""                  # For time
_h_c=0
_sethwclock=""
LOCALE="en_US.UTF-8"        # System locale. Default is "en_US.UTF-8"
LTS=0                       # Has the LTS Kernel been installed?
GRAPHIC_CARD=""             # graphics card
INTEGRATED_GC=""            # Integrated graphics card for NVIDIA
NVIDIA_INST=0               # Indicates if NVIDIA proprietary driver has been installed
SHOW_ONCE=0                 # Show de_wm information only once
_dm_menu_once=0             # Dm menu once forms to search dm
_nm_once=0                  # Nm menu once forms to search nm
_gengen_once=0              # General once forms menu
_archivers_once=0           # Archivers once forms menu
_ttf_once=0                 # TTF Theme once forms menu
_stpkg_once=0               # Standart packages once forms menu
_other_pkg_once=0           # Additional package once forms menu
_gengen_menu=""             # General packages save menu
archivers_menu=""           # Archivers save menu
_ttf_menu=""                # TTF Theme save menu
_standart_pkg_menu=""       # Standart package save menu
_other_pkg_menu=""          # Additional package save menu
_wifi_menu=""
_dm_desktop_menu=""
_list_dm_menu=""
_ldm_menu=""
_d_menu_once=0
_listdm_menu=""
_standart_pkg_menu=""
_multilib=0                                                     # Multilib additional repositoryes to qestion
_user_local=""                                                  # Forms User Locale in auto forms on Locale menu
_freefile=""                                                    # File of comand "free -h"
_swappiness=""                                                  # Variable to save parameter swappiness
_mem_file="/tmp/mem.conf"                                       # file of info memory
_mem_msg_file="/tmp/msginfo.nfo"                                # Information on swappiness
_File_of_Config="/tmp/00-sysctl.conf"                           # Temp configuration swappiness
_real_dir_swpns="${MOUNTPOINT}/etc/sysctl.d/"                   # Real dir to swappiness on config
_real_swappiness="${MOUNTPOINT}/etc/sysctl.d/00-sysctl.conf"    # File of full path swappiness config to install system

declare -a _devices                                             # Array scan mnt mount devices variables declare
declare -a _device_menu                                         # Array menu form on scan mnt mount devices variables declare
DEVICES=""                                                      # Array devices to clear
_isreserved=""                                                  # Percentage to setup reserved block count on root
_rsrvd_file="/tmp/rsrvd.nfo"                                    # File information to reserved block count
_tmp_fstab="/tmp/tmp.fstab"                                     # File information on tmp folder to FSTAB
_once_shwram=0                                                  # Once form memory information to mem file

_net_cntrl=0                                                    # Once run install qestion wireless programm
_shara_p=0                                                      # Once run install qestion shara programm
file_list_pkg="/tmp/flpkg.conf"                                 # File to forms on new lists to pkgs

_wifi_menu_form=0                                               # Once forms wifi menu on wifi adapter your PC
_list_wifi_adapter_pkg=""                                       # Search package to wifi adapter driver
_wifi_menu=""                                                   # Forms wifi menu to save

# Variables of keyboard parameters
_is_xkb=0
_skip=0
_switch_xkb=""
_indicate_xkd=""
_xkb_mdl=""
_xkb_list=""
_xkb_var=""
xkb_model=""
xkb_layout=""
xkb_variant=""
xkb_options=""

_once_conf_fscr=0                   # once config to windows fonts and screenfetch startup console
_usr_list=""                        # list of user to home folder
_usr_lst_menu=""                    # dialog menu list of user to home folder
_old_shell=""                       # old select shell for seccurity
_scrnf=0                           # Flag to screenfetch question setup
_bool_bash=0                        # bash once screenfetch config
_bool_fish=0                        # fish once screenfetch config
_bsh_stp_once=0                     # Once setup bash
_zsh_stp_once=0                     # Once setup zsh
_fsh_stp_once=0                     # Once setup fish

# Architecture
ARCHI=`uname -m`            # Display whether 32 or 64 bit system
SYSTEM="Unknown"            # Display whether system is BIOS or UEFI. Default is "unknown"
ROOT_PART=""                # ROOT partition
UEFI_PART=""                # UEFI partition
UEFI_MOUNT=""               # UEFI mountpoint
INST_DEV=""                 # Device where system has been installed
HIGHLIGHT=0                 # Highlight items for Main Menu
HIGHLIGHT_SUB=0             # Highlight items for submenus
SUB_MENU=""                 # Submenu to be highlighted

# Logical Volume Management
LVM=0                       # Logical Volume Management Detected?
LUKS=0                      # Luks Detected?
LVM_ROOT=0                  # LVM used for Root?
LVM_SEP_BOOT=0              # 1 = Seperate /boot, 2 = seperate /boot & LVM
LVM_DISABLE=0               # Option to allow user to deactive existing LVM
LVM_VG=""                   # Name of volume group to create
LVM_VG_MB=0                 # MB remaining of VG
LVM_LV_NAME=""              # Name of LV to create
LV_SIZE_INVALID=0           # Is LVM LV size entered valid?
VG_SIZE_TYPE=""             # Is VG in Gigabytes or Megabytes?

# LUKS
LUKS=0                                              # Luks Detected?
LUKS_DEV=""                                         # If encrypted, partition
LUKS_NAME=""                                        # Name given to encrypted partition
LUKS_UUID=""                                        # UUID used for comparison purposes
LUKS_OPT=""                                         # Default or user-defined?

# Installation
MOUNTPOINT="/mnt"           # Installation
MOUNT_TYPE=""               # "/dev/" for standard partitions, "/dev/mapper" for LVM
BTRFS=0                     # BTRFS used? "1" = btrfs alone, "2" = btrfs + subvolume(s)
BTRFS_OPTS="/tmp/.btrfs_opts" #BTRFS Mount options
BTRFS_MNT=""                # used for syslinux where /mnt is a btrfs subvolume

# Language Support
CURR_LOCALE="en_US.UTF-8"   # Default Locale
FONT=""                     # Set new font if necessary

# Edit Files
FILE=""                     # Which file is to be opened?
FILE2=""                    # Which second file is to be opened?
