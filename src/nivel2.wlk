 import paredes.*
import tablero.*
import wollok.game.*
import gaston.*
import enemigos.*
import puerta.*
import objetos.*
import sacerdote.*
import objetosNivelDos.*

object nivel2 {

	const ancho = game.width() - 1
	const largo = game.height() - 1
<<<<<<< HEAD
	
//	const property lavaArriba1 = new Lava(imagen = "lava.png", position = game.at(10, 1))
//	const property lavaArriba2 = new Lava(imagen = "lava.png", position = game.at(10, 2))
//	const property lavaArriba3 = new Lava(imagen = "lava.png", position = game.at(10, 3))
//	const property lavaArriba4 = new Lava(imagen = "lava.png", position = game.at(10, 4))
//	const property lavaArriba5 = new Lava(imagen = "lava.png", position = game.at(10, 5))
//	const property lavaArriba6 = new Lava(imagen = "lava.png", position = game.at(10, 6))
//	const property lavaArriba7 = new Lava(imagen = "lava.png", position = game.at(10, 7))
//	const property lavaArriba8 = new Lava(imagen = "lava.png", position = game.at(10, 8))
//	const property lavaArriba9 = new Lava(imagen = "lava.png", position = game.at(10, 9))
//	const property lavaArriba10 = new Lava(imagen = "lava.png", position = game.at(10, 10))
//	const property lavaArriba11 = new Lava(imagen = "lava.png", position = game.at(10, 11))
//	const property lavaArriba12 = new Lava(imagen = "lava.png", position = game.at(10, 12))
//	const property lavaArriba13 = new Lava(imagen = "lava.png", position = game.at(10, 13))
	
	const property bolaArriba1 = new BolaDeNieve(imagen = "bolaparaarriba.png", position = game.at(6, 2))
	const property bolaArriba2 = new BolaDeNieve(imagen = "bolaparaarriba.png", position = game.at(18, 2))
	const property bolaAbajo1 = new BolaDeNieve(imagen = "bolaparabajo.png", position = game.at(3, 10))
	const property bolaAbajo2 = new BolaDeNieve(imagen = "bolaparabajo.png", position = game.at(15, 10))
	
	const property lineaLava1 = [
	]
	
=======
	const property lavaArriba = new Proyectil(imagen = "lava.png", position = game.at(12, 2))//////////////
	//const property flechaAbajo1 = new Proyectil(imagen = "flechaabajo.png", position = game.at(9, 10))
	const property bolaArriba1 = new Proyectil(imagen = "boladefuego.png", position = game.at(6, 2))
	const property bolaArriba2 = new Proyectil(imagen = "boladefuego.png", position = game.at(18, 2))
	const property bolaAbajo1 = new Proyectil(imagen = "boladefuegoabajo.png", position = game.at(3, 10))
	const property bolaAbajo2 = new Proyectil(imagen = "boladefuegoabajo.png", position = game.at(15, 10))
>>>>>>> branch 'master' of https://github.com/algo1unsam/2019s1-juego-integrador-the-wolloker.git
	const property magoU1 = new Mago(position = game.at(3, 12))
	const property magoD1 = new Mago(position = game.at(6, 1))
	const property magoU2 = new Mago(position = game.at(15, 12))
	const property magoD2 = new Mago(position = game.at(18, 1))
	
//	const lineaDeLava1 = new Range(1, 13).forEach({n => self.crearLava(10,n,lista)})
//	
	method crearLava(x,y) = new Lava(imagen = "lava.png",position = game.at(x, y))
	
	method agregar(lista,obj){
		lista.add(obj)
		game.addVisual(obj)
	}
	
	method llenarLista(lista,x){
		self.agregar(lista,new Range(1, 13).forEach({n => self.crearLava(x,n)}))
	}
	
	method cargar() {
		controladorDeTablero.sacarTodo()
		self.agregarCosas()
		game.whenCollideDo(gaston, { objeto => gaston.teChocasteCon(objeto)})
		game.whenCollideDo(sacerdote, { cosa => sacerdote.teChocasteCon(cosa)})
		game.whenCollideDo(puerta, { e => puerta.pasoNivel2(e)})
		keyboard.right().onPressDo({ controladorDeTablero.moverDer(gaston)})
		keyboard.left().onPressDo({ controladorDeTablero.moverIzq(gaston)})
		keyboard.down().onPressDo({ controladorDeTablero.moverAba(gaston)})
		keyboard.up().onPressDo({ controladorDeTablero.moverArr(gaston)})
		self.llenarLista(lineaLava1,10)
		movedor.moverNivel2()
	}

	method cargarBordeV(x) {
		new Range(0,largo).forEach({ n => game.addVisualIn(new Pared(), game.at(x, n))})
	}

	method cargarBordeH(y) {
		new Range(1,ancho-1).forEach({ n => game.addVisualIn(new Pared(), game.at(n, y))})
	}

	method agregarCosas() {
		gaston.position(game.at(1, 6))
		game.addVisual(gaston)
		game.addVisualIn(sacerdote, game.at(1, 1))
		game.addVisual(bolaAbajo1)
		game.addVisual(magoU1)
		game.addVisual(bolaArriba1)
		game.addVisual(magoD1)
		
//		game.addVisual(lavaArriba1)
//		game.addVisual(lavaArriba2)
//		game.addVisual(lavaArriba3)
//		game.addVisual(lavaArriba4)
//		game.addVisual(lavaArriba5)
//		game.addVisual(lavaArriba6)
//		game.addVisual(lavaArriba7)
//		game.addVisual(lavaArriba8)
//		game.addVisual(lavaArriba9)
//		game.addVisual(lavaArriba10)
//		game.addVisual(lavaArriba11)
//		game.addVisual(lavaArriba12)
		//game.addVisual(lavaArriba13)
		
		game.addVisual(bolaAbajo2)
		game.addVisual(magoU2)
		game.addVisual(bolaArriba2)
		game.addVisual(magoD2)
		game.addVisualIn(puerta, game.at(22, 6))
		self.cargarBordeV(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(0)
		self.cargarBordeH(largo)
	}

	method gano() {
		keyboard.any().onPressDo({ self.gameOver()})
	}

	method gameOver() {
		controladorDeTablero.sacarTodo()
		keyboard.any().onPressDo({ game.stop()})
	}

}

