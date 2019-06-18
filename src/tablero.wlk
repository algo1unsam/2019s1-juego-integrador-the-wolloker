import wollok.game.*
import gaston.*
import nivel1.*
import paredes.*
import puzzle.*
import enemigos.*
import nivel2.*
import tablero.*
import objetosNivelDos.*

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
		self.darMovimiento(jefe, 200, "movimiento jefe", 4, 2, true, true, true)
	}

	method moverEnigma() {
		self.darMovimiento(enigma, 300, "movimiento Enigma", 0, 1, true, true, true)
	}

	method moverZombie() {
		self.darMovimiento(zombie, 500, "movimiento Zombie", 3, 2, true, true, true)
	}

	method darMovimiento(cosa, tiempo, nombre, limiteV, limiteH, idaYVuelta, arriba, derecha) {
		const objeto = new Limitador(up = arriba, right = derecha, limV = limiteV, limH = limiteH, objetoAMover = cosa, posInicial = cosa.position(), cambiaSentido = idaYVuelta)
		game.onTick(tiempo, nombre, {=>
			if (limiteV != 0) {
				if (objeto.up()) objeto.moverUp() else objeto.moverDown()
				objeto.sumarV()
			}
			if (limiteH != 0) {
				if (objeto.right()) objeto.moverRight() else objeto.moverLeft()
				objeto.sumarH()
			}
		})
	}

	method moverNivel2() {
		self.moverBola1Up()
		self.moverBola2Up()
		self.moverBola1Down()
		self.moverBola2Down()
		self.moverFlecha1Up()
		self.moverFlecha1Down()
	}

	method moverArriba(objeto, velocidad, nombre) {
		self.darMovimiento(objeto, velocidad, nombre, 13, 0, false, true, true)
	}

	method moverAbajo(objeto, velocidad, nombre) {
		self.darMovimiento(objeto, velocidad, nombre, 13, 0, false, false, true)
	}

	method moverBola1Up() {
		self.moverArriba(nivel2.bolaArriba1(), 30, "movimiento bolaArriba1")
	}

	method moverBola2Up() {
		self.moverArriba(nivel2.bolaArriba2(), 60, "movimiento bolaArriba2")
	}

	method moverBola1Down() {
		self.moverAbajo(nivel2.bolaAbajo1(), 60, "movimiento bolaAbajo1")
	}

	method moverBola2Down() {
		self.moverAbajo(nivel2.bolaAbajo2(), 25, "movimiento bolaAbajo2")
	}

	method moverFlecha1Up() {
		self.moverArriba(nivel2.flechaArriba1(), 20, "movimiento flechaArriba1")
	}

	method moverFlecha1Down() {
		self.moverAbajo(nivel2.flechaAbajo1(), 50, "movimiento flechaAbajo1")
	}

	method quitarTicksNivel1() {
		game.removeTickEvent("movimiento Enigma")
		game.removeTickEvent("movimiento Zombie")
		game.removeTickEvent("movimiento jefe")
	}
	method quitarTicksNivel2() {
			game.removeTickEvent("movimiento bolaArriba1")
			game.removeTickEvent("movimiento bolaArriba2")
			game.removeTickEvent("movimiento bolaAbajo1")
			game.removeTickEvent("movimiento bolaAbajo2")
			game.removeTickEvent("movimiento flechaArriba1")
			game.removeTickEvent("movimiento flechaAbajo1")
	}

}

class Limitador {

	var pasosV = 0
	var pasosH = 0
	var property up
	var property right
	const limV
	const limH
	const cambiaSentido
	const objetoAMover
	const posInicial

	method sumarV() {
		pasosV += 1
		self.debeCambiar()
	}

	method sumarH() {
		pasosH += 1
		self.debeCambiar()
	}

	method debeCambiar() {
		if (pasosV > limV) {
			if (cambiaSentido) self.cambiarSentido('y') else self.irAInicio()
			pasosV = 0
		}
		if (pasosH > limH) {
			if (cambiaSentido) self.cambiarSentido('x') else self.irAInicio()
			pasosH = 0
		}
	}

	method cambiarSentido(eje) {
		if (eje == 'x') right = not right
		if (eje == 'y') up = not up
	}

	method irAInicio() {
		objetoAMover.position(posInicial)
	}

	method moverUp() {
		objetoAMover.position(objetoAMover.position().up(1))
	}

	method moverDown() {
		objetoAMover.position(objetoAMover.position().down(1))
	}

	method moverRight() {
		objetoAMover.position(objetoAMover.position().right(1))
	}

	method moverLeft() {
		objetoAMover.position(objetoAMover.position().left(1))
	}

}

object controladorDeTablero {

	var property limiteSuperior = (game.height() - 1)
	var property limiteDerecho = (game.width() - 1)
	var property limiteCeroX = 0
	var property limiteCeroY = 0

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
		cosa.moverseA(posicion)
	}

}

