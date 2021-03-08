#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk as gtk
from GladeClasses import GladeClass as gldo

class Main(gldo.GladeObject):
	
	def __init__(self, glade_file_name, window_names):
		super().__init__(glade_file_name, window_names)

if __name__ == "__main__":
	main = Main("forms.glade", "Main")
	gtk.main()
