import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import nivel1.*

class Enemigos inherits CosaInteractiva {

	override method dejaPasar() = true

	method morir(cosa) {
		game.removeVisual(self)
		cosa.derrotasteA(self)
		casco.liberar(cosa)
	}

	method tieneLLave() = false

}

object enigma inherits Enemigos {

	override method position() {
		if (position == null) {
			self.position(game.at(1, 4))
		}
		return position
	}

	override method image() = "enigma.png"

	override method teChocasteCon(cosa) {
		if (cosa.tieneArmadura()) {
			self.morir(cosa)
			game.removeTickEvent("movimientoEnigma")
		} else {
			cosa.morir()
			game.say(cosa, "Creo que necesito una Armadura")
		}
	}

}

object zombie inherits Enemigos {

	override method position() {
		if (position == null) {
			self.position(game.at(8, 7))
		}
		return position
	}

	override method image() = "zombie.png"

	override method teChocasteCon(cosa) {
		if (cosa.espadaYArmadura()) {
			self.morir(cosa)
			game.removeTickEvent("movimientoZombie")
		} else {
			cosa.morir()
			game.say(cosa, "Necesito una Espada...")
		}
	}

}

object jefe inherits Enemigos {

	const esbirros = [ enigma, zombie ]
	var jefeVivo = true

	method estaVivo() = jefeVivo

	override method position() {
		if (position == null) {
			self.position(game.at(17, 1))
		}
		return position
	}

	override method image() = "jefe5.png"

	method todosLosEnemigosMuertos(cosa) = cosa.derrotados().asSet() == esbirros.asSet()

	override method morir(cosa) {
		game.removeTickEvent("movimientoJefe")
		game.removeVisual(self)
		llave.aparecer()
		jefeVivo = false
	}

	override method teChocasteCon(cosa) {
		if (cosa.fullEquipoSinEscudo() and self.todosLosEnemigosMuertos(cosa)) {
			self.morir(cosa)
		} else {
			cosa.morir()
			game.say(cosa, "Tengo que estar bien equipado")
		}
	}

}

