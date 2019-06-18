import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import enemigos.*

class CosaInteractiva inherits CosaEnTablero {

	override method dejaPasar() = true

	method teChocasteCon(cosa) {
	}

	method aparecer() {
		game.addVisual(self)
	}

}

class Equipo inherits CosaInteractiva {

	override method teChocasteCon(cosa) {
		cosa.equipo().add(self)
		game.removeVisual(self)
	}

}

object casco inherits Equipo {

	override method image() = "casco.png"

	override method position() = game.at(19, 4)

	override method teChocasteCon(cosa) {
		if (cosa.puedeLevantar()) {
			if (cosa.espadaYArmadura()) {
				cosa.conCasco()
				super(cosa)
			}
		}
	}

	method liberar(cosa) {
		if (jefe.todosLosEnemigosMuertos(cosa)) self.aparecer()
	}

}

object espada inherits Equipo {

	override method image() = "Espada2.png"

	override method position() = game.at(2, 11)

	override method teChocasteCon(cosa) {
		super(cosa)
		if (cosa.tieneArmadura()) {
			cosa.conEspadaYArmadura()
		} else {
			cosa.conEspada()
		}
	}

}

object armadura inherits Equipo {

	override method image() = "Armadura1.png"

	override method position() = game.at(5, 1)

	override method teChocasteCon(cosa) {
		super(cosa)
		if (gaston.tieneEspada()) {
			gaston.conEspadaYArmadura()
		} else {
			gaston.conArmadura()
		}
	}

}

object llave inherits Equipo {

	override method image() = "llave.png"

	override method position() = game.at(18, 2)

}

