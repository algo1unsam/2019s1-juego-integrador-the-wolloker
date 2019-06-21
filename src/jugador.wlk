import wollok.game.*
import paredes.*
import puzzle.*
import tablero.*
import enemigos.*
import objetos.*

class Jugador inherits CosaInteractiva {

	const property equipo = []
	var estaVivo = true

//	method estaVivo() = estaVivo
	override method image() = self.imagenSegunEquipo()

	method sinEquipo() = equipo.isEmpty()

	method tieneArmadura() = equipo.contains(armadura)

	method tieneEspada() = equipo.contains(espada)

	method tieneCasco() = equipo.contains(casco)

	method tieneEscudo() = equipo.contains(escudo)

	method espadaYArmadura() = self.tieneArmadura() and self.tieneEspada()

	method fullEquipoSinEscudo() = self.espadaYArmadura() and self.tieneCasco()

	method fullEquipoConEscudo() = self.espadaYArmadura() and self.tieneCasco() and self.tieneEscudo()

	method tieneLlave() = equipo.contains(llave)

	method puedeLevantar() = estaVivo

	method cantEquipo() = equipo.size()

	method imagenSegunEquipo() {
		return if (not estaVivo) self.casper() else if (self.cantEquipo() == 0) {
			self.desequipado()
		} else {
			if (self.cantEquipo() == 1) {
				if (self.tieneArmadura()) {
					self.soloArmadura()
				} else {
					if (self.tieneEspada()) {
						self.soloEspada()
					} else {
						if (self.tieneEscudo()) {
							self.soloEscudo()
						} else {
							self.desequipado()
						}
					}
				}
			} else {
				if (self.cantEquipo() == 2 and self.espadaYArmadura()) {
					self.conEspadaYArmadura()
				} else {
					if (self.cantEquipo() >=3 and self.fullEquipoSinEscudo()) {
						self.fullSinEscudo()
					} else {
						if (self.fullEquipoConEscudo()) self.full()
					}
				}
			}
		}
	}

	method full() = "playerFull.png"

	method fullSinEscudo() = "playerArmEspCas.png"

	method conEspadaYArmadura() = "playerArmEsp.png"

	method soloEscudo() = "playerEscudo.png"

	method soloArmadura() = "playerArmadura.png"

	method soloEspada() = "playerEspada.png"

	method desequipado() = "playerSinEquipo.png"

	method casper() = "casper.png"

	method morir() {
		estaVivo = false
	}

	method tirarEquipo(elemento) {
		equipo.remove(elemento)
	}

	method tirarTodo() {
		equipo.clear()
	}

	method revivir() {
		if (not estaVivo) {
			estaVivo = true
			self.moverseA(self.position().up(1))
		}
	}

	override method teChocasteCon(cosa) {
		if (estaVivo) cosa.teChocasteCon(self)
	}

	method moverseA(posicion) {
		if (self.posicionValida(posicion)) {
			self.position(posicion)
		}
	}

	method posicionValida(posicion) {
		return (controladorDeTablero.cosasDejanPasar(posicion) or not estaVivo) and not controladorDeTablero.seVaDelTablero(posicion)
	}

	method teGolpeo() {
		self.morir()
	}

}

