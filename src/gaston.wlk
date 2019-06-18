import wollok.game.*
import paredes.*
import puzzle.*
import tablero.*
import enemigos.*
import objetos.*

object gaston inherits CosaInteractiva {

	const property equipo = []
	const property derrotados = []
	var estaVivo = true
	var property image = "player1.png"

	override method position() {
		if (position == null) {
			self.position(game.at(1, 1))
		}
		return position
	}

	method estaVivo() = estaVivo

	override method image() = "player1.png"

	method tieneArmadura() = equipo.contains(armadura)

	method tieneEspada() = equipo.contains(espada)

	method tieneCasco() = equipo.contains(casco)

	method espadaYArmadura() = self.tieneArmadura() and self.tieneEspada()

	method fullEquipo() = self.espadaYArmadura() and self.tieneCasco()

	method puedeLevantar() = estaVivo

	method conCasco() {
		image = "player5.png"
	}

	method conArmadura() {
		image = "player2.png"
	}

	method conEspada() {
		image = "player4.png"
	}

	method conEspadaYArmadura() {
		image = "player3.png"
	}

	method tieneLlave() = equipo.contains(llave)

	method morir() {
		estaVivo = false
		image = "casper.png"
		self.dejarEquipo()
		self.equipo().clear()
	}

	method dejarEquipo() {
		equipo.forEach{ objeto => objeto.aparecer()}
		self.equipo().clear()
	}

	method derrotasteA(enemy) {
		derrotados.add(enemy)
	}

	method revivir() {
		if (not self.estaVivo()) {
			estaVivo = true
			image = "player1.png"
			self.position(self.position().up(1))
		}
	}

	override method teChocasteCon(cosa) {
		if (estaVivo) cosa.teChocasteCon(self)
	}

	method moverseA(posicion) {
		if (controladorDeTablero.cosasDejanPasar(posicion) or not self.estaVivo()) self.position(posicion)
	}

	method pasasteNivel1() {
		image = "player5.png"
		equipo.clear()
		derrotados.clear()
	}

}

