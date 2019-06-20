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

	override method position() = game.at(19, 7)

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

	override method position() = game.at(3, 4)

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

	override method position() = game.at(11,11)

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

	override method position() = game.at(17, 2)

}

object escudo inherits Equipo{
	
	
	override method image() = "escudo.png"

	override method position() = game.at(1,12)

	override method teChocasteCon(cosa) {
		super(cosa)
		if (gaston.fullEquipo()) {
			gaston.conEscudo()
		} else {
			gaston.soloEscudo()
		}
	}
	
}

