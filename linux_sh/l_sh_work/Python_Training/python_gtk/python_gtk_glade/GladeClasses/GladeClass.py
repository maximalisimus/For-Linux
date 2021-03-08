import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk as gtk

class GladeObject:
	
	def __init__(self, infile, window_name, isModal = False):
		self.isModal = isModal
		gladeFile = infile
		self.builder = gtk.Builder()
		self.builder.add_from_file(gladeFile)
		self.builder.connect_signals(self)
		
		self.window = self.builder.get_object(window_name)
		if isModal == True:
			self.window.set_modal(True)
			self.button_exit = self.builder.get_object("ButtonExit")
			self.button_exit.connect("clicked", self.close)
			self.window.connect("destroy", self.close)
		else:
			self.window.connect("delete-event", gtk.main_quit)
		self.window.show()
		
	def ClickExit(self, widget):
		if self.isModal == False: gtk.main_quit()
		else: self.close()
	
	def close(self, widget):
		self.window.destroy()

	def getIsModal(self):
		return self.isModal
	
	def setIsModal(self,onModal = False):
		self.isModal = onModal

if __name__ == "__main__":
	Main = GladeObject("forms.glade", "Main")
	gtk.main()
