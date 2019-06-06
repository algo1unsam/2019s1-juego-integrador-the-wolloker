import wollok.game.*
import mapa.*
import paredes.*
//import puzzle.*
import tablero.*
import enemigos.*

object gaston inherits CosaEnTablero {

	var property equipo = []
	var property enemigos = [ enigma, zombie ]
	var property tieneArmadura = false
	var property tieneEspada = false
	var property espadaYArmadura = false
	var property estoyMuerto = false
	var property tengoLlave = false
	var property fullEquipo = false
	var property image = "player1.png"

	override method dejaPasar() = true

	override method image() = "player1.png"

	method conCasco() {
		fullEquipo = true
		image = "player5.png"
	}

	method conArmadura() {
		tieneArmadura = true
		image = "player2.png"
	}

	method conEspada() {
		tieneEspada = true
		image = "player4.png"
	}

	method conEspadaYArmadura() {
		espadaYArmadura = true
		image = "player3.png"
	}

	method tieneLlave() {
		tengoLlave = true
	}

	method morir() {
		estoyMuerto = true
		image = gastonMuerto.image()
		equipo.forEach{ objeto => objeto.reaparecer()}
		self.equipo().clear()
	}

	method revivir() {
		estoyMuerto = false
		image = self.image()
	}

	method moverIzq() {
		self.moverA(self.position().left(1))
	}

	method moverDer() {
		self.moverA(self.position().right(1))
	}

	method moverArr() {
		self.moverA(self.position().up(1))
	}

	method moverAba() {
		self.moverA(self.position().down(1))
	}

	method moverA(posicion) {
		if (controladorDeTablero.cosasDejanPasar(posicion)) {
			self.position(posicion)
		}
	}

}

object gastonMuerto {

	method image() = "casper.png"

}

