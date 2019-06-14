import wollok.game.*
import mapa.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*

class Enemigos inherits CosaInteractiva {

	override method dejaPasar() = true

	method morir(cosa) {
		game.removeVisual(self)
		cosa.derrotasteA(self)
	}

}

object enigma inherits Enemigos {

	override method image() = "enigma.png"

	override method teChocasteCon(cosa) {
		if (cosa.tieneArmadura()) {
			self.morir(cosa)
		} else {
			cosa.morir()
		}
	}

}

object zombie inherits Enemigos {

	override method image() = "zombie.png"

	override method teChocasteCon(cosa) {
		if (gaston.espadaYArmadura()) {
			self.morir(cosa)
		} else {
			cosa.morir()
		}
	}

}

object jefe inherits Enemigos {

	var sentidoUp = true
	var sentidoRight = true
	var movimientos = 0
	var movimientos2 = 0
	const esbirros = [ enigma, zombie ]

	method sentidoUp() = sentidoUp

	override method position() {
		if (position == null) {
			self.position(game.at(18, 3))
		}
		return position
	}

	override method image() = "jefe5.png"

	method todosLosEnemigosMuertos(cosa) = cosa.derrotados().asSet() == esbirros.asSet()

	override method morir(cosa) {
		game.removeVisual(self)
		llave.aparecer()
	}

	override method teChocasteCon(cosa) {
		if (cosa.fullEquipo() and self.todosLosEnemigosMuertos(cosa)) {
			self.morir(cosa)
		} else {
			cosa.morir()
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

