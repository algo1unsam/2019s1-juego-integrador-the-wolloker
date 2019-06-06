import wollok.game.*
import mapa.*
import paredes.*
import tablero.*
import gaston.*
import enemigos.*

class Fantasma {

	method dejaPasar()=true

	method teChocasteConFantasma() {
		if (gaston.estoyMuerto()) {
			game.say(gaston, "Estoy muerto!")
		}
	}

	method reaparecer() {
		game.addVisual(self)
	}

}

object casco inherits Fantasma {

	method image() = "casco.png"

	method position() = game.at(21, 11)

	method teChocasteConGaston() {
		gaston.equipo().add(self)
		if (gaston.espadaYArmadura()) {
			gaston.conCasco()
			game.removeVisual(self)
		}
	}

}

object espada inherits Fantasma {

	method image() = "Espada2.png"

	method position() = game.at(2, 11)

	method teChocasteConGaston() {
		gaston.equipo().add(self)
		if (gaston.tieneArmadura()) {
			gaston.conEspadaYArmadura()
		} else {
			gaston.conEspada()
		}
		game.removeVisual(self)
	}

}

object armadura inherits Fantasma {

	method image() = "Armadura1.png"

	method position() = game.at(5, 1)

	method teChocasteConGaston() {
		gaston.equipo().add(self)
		if (gaston.tieneEspada()) {
			gaston.conEspadaYArmadura()
		} else {
			gaston.conArmadura()
		}
		game.removeVisual(self)
	}

}

object llave inherits Fantasma {

	method image() = "llave.png"

	method position() = game.at(18, 2)

	method aparecer() {
		game.addVisual(self)
	}

	method teChocasteConGaston() {
		gaston.tieneLlave()
		game.removeVisual(self)
	}

}

