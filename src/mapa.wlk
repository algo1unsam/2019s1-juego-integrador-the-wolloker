import wollok.game.* 
import paredes.*
import Gaston.*

object nivel1{
	const vertical = 12
	const horizontal = 7
	const ancho = game.width() - 1
	const largo = game.height() - 1
		
	method cargar(){
		
		self.cargarBordeV(0)
		self.cargarBordeH(0)
		self.cargarBordeV(ancho)
		self.cargarBordeH(largo)
		self.cargarLineaCentralV()
		self.cargarLineaCentralH()
	}
	
	method cargarBordeV(x){
		new Range(0,largo).forEach({n => game.addVisualIn(new Pared(),game.at(x,n))})
	}
	
	method cargarBordeH(y){
		new Range(0,ancho).forEach({n => game.addVisualIn(new Pared(),game.at(n,y))})
	}
	
	method cargarLineaCentralV(){
		new Range(1,largo-2).forEach({n => game.addVisualIn(new Pared(),game.at(vertical,n))})
	}
	
	method cargarLineaCentralH(){
		new Range(2,vertical-1).forEach({n => game.addVisualIn(new Pared(),game.at(n,horizontal))})
	}
}