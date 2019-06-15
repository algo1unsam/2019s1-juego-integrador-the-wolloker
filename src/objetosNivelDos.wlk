import wollok.game.*
import nivel2.*
import paredes.*
import tablero.*
import gaston.*
import objetos.*
import enemigos.*

class Mago {

	method image() = "mago.png"

}

class Arquero {

	method image() = "arquero.png"

}
//---------------------------------------------------------
// revisar todo lo de abajo e implementar clase
class Proyectil inherits CosaEnTablero {

	var posi = game.at(12, 2)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "flechaarriba.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(12, 2))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object flechaArriba1 inherits CosaEnTablero {

	var posi = game.at(12, 2)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "flechaarriba.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(12, 2))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object flechaAbajo1 inherits CosaEnTablero {

	var posi = game.at(9, 10)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "flechaabajo.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(9, 10))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object bolaArriba1 inherits CosaEnTablero {

	var posi = game.at(6, 2)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "bolaparaarriba.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(6, 2))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object bolaArriba2 inherits CosaEnTablero {

	var posi = game.at(18, 2)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "bolaparaarriba.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(18, 2))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object bolaAbajo1 inherits CosaEnTablero {

	var posi = game.at(3, 10)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "bolaparabajo.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(3, 10))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

object bolaAbajo2 inherits CosaEnTablero {

	var posi = game.at(15, 10)
	var sentidoUp = true
	var movimientos = 0

	override method position() = posi

	override method position(pos) {
		posi = pos
	}

	override method dejaPasar() = true

	override method image() = "bolaparabajo.png"

	method teChocasteConGaston() {
		gaston.morir()
	}

	method sentidoUp() = sentidoUp

	method sumarMov() {
		movimientos += 1
		if (self.seMovio(13, movimientos)) {
			self.position(game.at(15, 10))
			movimientos = 0
		}
	}

	method seMovio(cant, contador) = contador == cant

}

