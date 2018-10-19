class VagonDePasajero{
	var property largo
	var property ancho
	var property banios
	method cantidadDePasajeros(){
		if (ancho <= 2.5) return largo * 8
		else return largo* 10  
	}
	method pesoMaximo() = self.cantidadDePasajeros()*80
}


class VagonDeCarga{
	var property cargaMaxima 
	var property banios = 0
	method cantidadDePasajeros() = 0
	
	method pesoMaximo() = cargaMaxima + 160
}

class Locomotora {
	var property peso 
	var property pesoMaximoQuePuedeArrastrar 
	var property velocidadMaxima
	method arrastreUtil()= self.pesoMaximoQuePuedeArrastrar() - self.peso()
}