import wollok.game.*
import mapa.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*

class Enemigos inherits CosaEnTablero {

	var property estoyMuerto = false

	override method dejaPasar() = true

	method morir() {
		estoyMuerto = true
		game.removeVisual(self)
	}

	method teChocasteConFantasma() {
		if (gaston.estoyMuerto()) {
			game.say(gaston, "Estoy muerto!")
		}
	}

}

object enigma inherits Enemigos {

	override method image() = "enigma.png"

	method teChocasteConGaston() {
		if (gaston.tieneArmadura()) {
			self.morir()
		} else {
			gaston.morir()
		}
	}

}

object zombie inherits Enemigos {

	override method image() = "zombie.png"

	method teChocasteConGaston() {
		if (gaston.espadaYArmadura()) {
			self.morir()
		} else {
			gaston.morir()
		}
	}

}

object jefe inherits Enemigos {

	var posi = game.at(18, 3)

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method image() = "jefe5.png"

	method todosLosEnemigosMuertos() {
		return gaston.enemigos().all{ enemigo => enemigo.estoyMuerto() }
	}

	override method morir() {
		game.removeVisual(self)
		llave.aparecer()
	}

	method teChocasteConGaston() {
		if (gaston.fullEquipo() and self.todosLosEnemigosMuertos()) {
			self.morir()
		} else {
			gaston.morir()
		}
	}

}

