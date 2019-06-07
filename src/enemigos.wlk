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

	var sentidoUp = true
	var sentidoRight = true
	var movimientos = 0
	var movimientos2 = 0

	method sentidoUp() = sentidoUp

	override method position() = if (position == null) self.position(game.at(18, 3)) else position

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

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(3, movimientos)) {
			sentidoUp = not sentidoUp
			movimientos = 0
		}
	}

	method sumarMov2() {
		movimientos2 += 1
		if (self.seMovio(4, movimientos2)) {
			sentidoRight = not sentidoRight
			movimientos2 = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

	method sentidoRight() = sentidoRight

}

