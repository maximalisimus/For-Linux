#!/usr/bin/env python3

import gi

gi.require_version('Gtk', '3.0')

from gi.repository import Gtk as gtk

class Main:
	
	def __init__(self):
		gladeFile = "forms.glade"
		self.builder = gtk.Builder()
		self.builder.add_from_file(gladeFile)
		self.builder.connect_signals(self)
		
		window = self.builder.get_object("Main")
		window.connect("delete-event", gtk.main_quit)
		window.show()
		
	def ClickExit(self, widget):
		gtk.main_quit()

if __name__ == "__main__":
	main = Main()
	gtk.main()
