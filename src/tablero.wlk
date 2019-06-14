import wollok.game.*
import gaston.*
import mapa.*
import paredes.*
import puzzle.*
import enemigos.*

class CosaEnTablero {

	/*cosas en tablero va a ser la superclase de la van a heredar todos los objetos del
	 *  tablero
	 */
	var property position

	method image()

	method dejaPasar()

}

object movedor {

	method moverNivel1() {
		self.moverJefe()
		self.moverEnigma()
		self.moverZombie()
	}

	method moverJefe() {
		self.darMovimiento(jefe, 200, "movimiento jefe", 4, 2)
	}

	method moverEnigma() {
		self.darMovimiento(enigma, 300, "movimiento Enigma", 0, 2)
	}

	method moverZombie() {
		self.darMovimiento(zombie, 800, "movimiento Zombie", 4, 0)
	}

	method darMovimiento(cosa, tiempo, nombre, limiteV, limiteH) {
		const objeto = new Limitador(limV = limiteV, limH = limiteH)
		game.onTick(tiempo, nombre, {=>
			if (limiteV != 0) {
				if (objeto.up()) cosa.position(cosa.position().up(1)) else cosa.position(cosa.position().down(1))
				objeto.sumarV()
			}
			if (limiteH != 0) {
				if (objeto.right()) cosa.position(cosa.position().right(1)) else cosa.position(cosa.position().left(1))
				objeto.sumarH()
			}
		})
	}

}

class Limitador {

	var pasosV = 0
	var pasosH = 0
	var property up = true
	var property right = true
	const limV
	const limH

	method sumarV() {
		pasosV += 1
		self.debeCambiarSentido()
	}

	method sumarH() {
		pasosH += 1
		self.debeCambiarSentido()
	}

	method debeCambiarSentido() {
		if (pasosV > limV) {
			up = not up
			pasosV = 0
		}
		if (pasosH > limH) {
			right = not right
			pasosH = 0
		}
	}

}

//	var sentidoUp = true
//	var sentidoRight = true
//	var movimientos = 0
//	var movimientos2 = 0
//	const esbirros = [ enigma, zombie ]
//
//	method sentidoUp() = sentidoUp
//
//	override method position() {
//		if (position == null) {
//			self.position(game.at(18, 3))
//		}
//		return position
//	}
//
//	override method image() = "jefe5.png"
//
//	method todosLosEnemigosMuertos(cosa) = cosa.derrotados().asSet() == esbirros.asSet()
//
//	override method morir(cosa) {
//		game.removeVisual(self)
//		llave.aparecer()
//	}
//
//	override method teChocasteCon(cosa) {
//		if (cosa.fullEquipo() and self.todosLosEnemigosMuertos(cosa)) {
//			self.morir(cosa)
//		} else {
//			cosa.morir()
//		}
//	}
//
//	method sumarMov() {
//		movimientos += 1
//		if (self.seMovio(3, movimientos)) {
//			sentidoUp = not sentidoUp
//			movimientos = 0
//		}
//	}
//
//	method sumarMov2() {
//		movimientos2 += 1
//		if (self.seMovio(4, movimientos2)) {
//			sentidoRight = not sentidoRight
//			movimientos2 = 0
//		}
//	}
//
//	method seMovio(cant, contador) = contador == cant
//
//	method sentidoRight() = sentidoRight
//
object controladorDeTablero {

	var property limiteSuperior = (game.height() - 1)
	var property limiteDerecho = (game.width() - 1)
	var property limiteCeroX = 0
	var property limiteCeroY = 0

//	var property jugador=gaston
	/*aca se manda la proxima ubicacion */
	method sePuedeMoverA(posicion) = not self.seVaDelTablero(posicion) and (self.cosasDejanPasar(posicion) or self.lugarEstaVacio(posicion))

	method seVaDelTablero(posicion) = self.seVaDeAbajo(posicion) or self.seVaDeArriba(posicion) or self.seVaDeIzq(posicion) or self.seVaDeDer(posicion)

//----------------------------------------------------------------------------------------------------
	/*estas son las comprobaciones de si se sale de cada uno de los bordes */
	method seVaDeAbajo(posicion) = posicion.y() < self.limiteCeroY()

	method seVaDeArriba(posicion) = posicion.y() > self.limiteSuperior()

	method seVaDeIzq(posicion) = posicion.x() < self.limiteCeroX()

	method seVaDeDer(posicion) = posicion.x() > self.limiteDerecho()

//----------------------------------------------------------------------------------------------------
	method cosasDejanPasar(posicion) = self.cosasEn(posicion).all({ c => c.dejaPasar() })

	method cosasEn(posicion) = game.getObjectsIn(posicion)

	method lugarEstaVacio(posicion) = self.cosasEn(posicion).isEmpty()

//*************************************************************************************
	/*ver si sirve para algo lo que sigue */
	method sacarTodo() {
		new Range(0,self.limiteSuperior()).forEach({ y => new Range(0, self.limiteDerecho()).forEach({ x => self.removerCosasEn(game.at(x, y))})})
	}

	method removerCosasEn(posicion) {
		self.cosasEn(posicion).forEach({ c => game.removeVisual(c)})
	}

	method moverIzq(cosa) {
		self.moverA(cosa.position().left(1), cosa)
	}

	method moverDer(cosa) {
		self.moverA(cosa.position().right(1), cosa)
	}

	method moverArr(cosa) {
		self.moverA(cosa.position().up(1), cosa)
	}

	method moverAba(cosa) {
		self.moverA(cosa.position().down(1), cosa)
	}

	method moverA(posicion, cosa) {
		if (self.cosasDejanPasar(posicion)) cosa.position(posicion)
	}

}

