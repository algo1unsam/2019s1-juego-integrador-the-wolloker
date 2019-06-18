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

object scheduler {

	var count = 0

	method schedule(milliseconds, action) {
		count += 1
		const name = "scheduler" + count
		game.onTick(milliseconds, name, { =>
			action.apply()
			game.removeTickEvent(name)
		})
	}

}

object movedor {

	method moverNivel1() {
		self.moverJefe()
		self.moverEnigma()
		self.moverZombie()
		nivel1.plantarBomba()

	}
	

	


	method moverJefe() {
		self.darMovimiento(jefe, 600, "movimientoJefe", 4, 2, true, true, true, jefe)
	}

	method moverEnigma() {
		self.darMovimiento(enigma, 300, "movimientoEnigma", 0, 1, true, true, true, enigma)
	}

	method moverZombie() {
		self.darMovimiento(zombie, 500, "movimientoZombie", 3, 2, true, true, true, zombie)
	}

	method darMovimiento(cosa, tiempo, nombre, limiteV, limiteH, idaYVuelta, arriba, derecha, enemigo) {
		const objeto = new Limitador(up = arriba, right = derecha, limV = limiteV, limH = limiteH, objetoAMover = cosa, lanzador = enemigo, cambiaSentido = idaYVuelta)
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
	
//	method moverLava(nombre, cosa){
//		game.onTick(600, nombre, )
//	}

	method moverNivel2() {
		self.moverBola1Up()
		self.moverBola2Up()
		self.moverBola1Down()
		self.moverBola2Down()
		self.moverFlecha1Up()//////////////////
//		self.moverFlecha1Down()
	}

	method moverArriba(objeto, velocidad, nombre, enemigo) {
		self.darMovimiento(objeto, velocidad, nombre, 13, 0, false, true, true, enemigo)
	}

	method moverAbajo(objeto, velocidad, nombre, enemigo) {
		self.darMovimiento(objeto, velocidad, nombre, 13, 0, false, false, true, enemigo)
	}

	method moverBola1Up() {
		self.moverArriba(nivel2.bolaArriba1(), 30, "movimientoBolaArriba1", nivel2.magoD1())
	}

	method moverBola2Up() {
		self.moverArriba(nivel2.bolaArriba2(), 60, "movimientoBolaArriba2", nivel2.magoD2())
	}

	method moverBola1Down() {
		self.moverAbajo(nivel2.bolaAbajo1(), 60, "movimientoBolaAbajo1", nivel2.magoU1())
	}

	method moverBola2Down() {
		self.moverAbajo(nivel2.bolaAbajo2(), 25, "movimientoBolaAbajo2", nivel2.magoU2())
	}

	method moverFlecha1Up() {/////////////////////
		self.moverArriba(nivel2.lavaArriba(), 20, "movimientoLavaArriba", nivel2.arqD1())
	}

//	method moverFlecha1Down() {
//		self.moverAbajo(nivel2.lavaArriba(), 50, "movimientoLavaArriba", nivel2.arqU1())
//	}

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
	const lanzador

	method posInicial() = lanzador.position()

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
		objetoAMover.position(self.posInicial())
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
	method sacarTodo() {
		game.clear()
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

