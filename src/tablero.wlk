import wollok.game.*
import gaston.*
import nivel2.*
import paredes.*
import puzzle.*
import enemigos.*
import nivel2.*

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
		self.darMovimiento(enigma, 300, "movimiento Enigma", 0, 1)
	}

	method moverZombie() {
		self.darMovimiento(zombie, 500, "movimiento Zombie", 3, 2)
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

	method moverNivel2() {
//		self.moverBola1Up()
//		self.moverBola2Up()
//		self.moverBola1Down()
//		self.moverBola2Down()
//		self.moverFlecha1Up()
//		self.moverFlecha2Up()
	}

//	method moverBola1Up() {
//		self.darMovimiento(bolaArriba1, 30, "bola arriba1", 3, 2)
//	}
//	
//	game.onTick(30, "bola arriba1", {=>
//			bolaArriba1.position(bolaArriba1.position().up(1))
//			bolaArriba1.sumarMov()
//	})
//	game.onTick(60, "bola arriba2", {=>
//			bolaArriba2.position(bolaArriba2.position().up(1))
//			bolaArriba2.sumarMov()
//	})
//	game.onTick(20, "flecha arriba1", {=>
//			flechaArriba1.position(flechaArriba1.position().up(1))
//			flechaArriba1.sumarMov()
//	})
//	game.onTick(50, "flecha abajo1", {=>
//			flechaAbajo1.position(flechaAbajo1.position().down(1))
//			flechaAbajo1.sumarMov()
//	})
//	game.onTick(60, "bola abajo1", {=>
//			bolaAbajo1.position(bolaAbajo1.position().down(1))
//			bolaAbajo1.sumarMov()
//	})
//	game.onTick(25, "bola abajo2", {=>
//			bolaAbajo2.position(bolaAbajo2.position().down(1))
//			bolaAbajo2.sumarMov()
//	})
//	
//
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
		cosa.moverseA(posicion)
	}

}

