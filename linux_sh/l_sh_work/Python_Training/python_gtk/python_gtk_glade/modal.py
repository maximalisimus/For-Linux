#!/usr/bin/env python3

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk as gtk

from GladeClasses import GladeClass as gldo

class Main(gldo.GladeObject):
	
	def __init__(self, glade_file_name, window_names, onModal = False):
		super().__init__(glade_file_name, window_names, onModal)

class MainWindow(gtk.Window):
	
	def __init__(self):
		gtk.Window.__init__(self,title="My titles")
		self.set_border_width(30)
		layout = gtk.Box(spacing=6)
		self.add(layout)
		
		button = gtk.Button("Click me")
		button.connect("clicked", self.on_file_clicked)
		layout.add(button)
		
	def on_file_clicked(self, widget):
		main = Main("forms2.glade", "Main", True)

window = MainWindow()
window.connect("delete-event", gtk.main_quit)
window.show_all()
gtk.main()
