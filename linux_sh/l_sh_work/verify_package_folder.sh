#!/bin/bash
ABSOLUT_FILENAME=$(readlink -e "$0")
filesdir=$(dirname "$ABSOLUT_FILENAME")
_eml_folder="$filesdir/packages/emulators"
_aur_pkg_folder="$filesdir/packages"
_pkg_manager_folder="$filesdir/packages/package-manager"
_aur_pkg_winfnts="$_aur_pkg_folder/windowsfonts.tar.gz"
_aif_temp_folder="$filesdir/aif-temp"
_aif_temp_aur_dir="$_aif_temp_folder/aif/packages"
_aif_temp_eml_dir="$_aif_temp_aur_dir/emulators"
_aif_temp_pm_dir="$_aif_temp_aur_dir/package-manager"
_aif_temp_winfnts="$_aif_temp_aur_dir/windowsfonts.tar.gz"
aif_master_git="https://github.com/maximalisimus/aif-master.git"
vrf_cnt_fls()
{
    gt_cln_all()
    {
        mkdir -p "$_aif_temp_folder"
        git clone "$aif_master_git" "$_aif_temp_folder"
        wait
    }
    gt_cln_eml()
    {
        [[ -e "$_aif_temp_folder" ]] || gt_cln_all
        wait
        mkdir -p "$_eml_folder"
        cp -Rfa "$_aif_temp_eml_dir"/* "$_eml_folder"
        wait
    }
    gt_cln_pm()
    {
        [[ -e "$_aif_temp_folder" ]] || gt_cln_all
        wait
        mkdir -p "$_pkg_manager_folder"
        cp -Rfa "$_aif_temp_pm_dir"/* "$_pkg_manager_folder"
        wait
    }
    if [[ -e "$_aur_pkg_folder" ]]; then
        echo "$_aur_pkg_folder/ is exists"
        if [[ -e "$_eml_folder" ]]; then
            _temp=$(find "$_eml_folder" -maxdepth 1 -type f | wc -l)
            if [ $_temp  -le 2 ]; then
                gt_cln_eml
            fi
        else
            gt_cln_eml
        fi
        if [[ -e "$_pkg_manager_folder" ]]; then
            _temp=$(find "$_pkg_manager_folder" -maxdepth 1 -type f | wc -l)
            if [ $_temp  -le 2 ]; then
                gt_cln_pm
            fi
        else
            gt_cln_pm
        fi
        if [[ -e "$_aur_pkg_winfnts" ]]; then
            echo "$_aur_pkg_winfnts is exists"
        else
            [[ -e "$_aif_temp_folder" ]] || gt_cln_all
            wait
            cp -f "$_aif_temp_winfnts" "$_aur_pkg_folder"
            wait
        fi
    else
        [[ -e "$_aif_temp_folder" ]] || gt_cln_all
        wait
        mkdir -p "$_aur_pkg_folder"
        cp -Rfa "$_aif_temp_aur_dir"/* "$_aur_pkg_folder"/
        wait
    fi
    unset _temp
    rm -rf "$_aif_temp_folder"
    wait
}
vrf_cnt_fls
exit 0
