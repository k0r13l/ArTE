import UIKit

/*
 * Estructura para dibujar lineas
 */
struct Point {
    var color: UIColor?
    var width: CGFloat?
    var opacidad: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]?) {
        self.color = color
        self.points = points
    }
}

class CanvasView: UIView {

    var lines = [Point]()
    var anchoTrazo: CGFloat = 1.0
    var colorTrazo: UIColor = .black
    var opacidadTrazo: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Se obtiene el context con el que se dibuja
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        // Ciclo que itera sobre cada punto para pintarlo
        lines.forEach { (line) in
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                // Asigna el color de la línea al contexto para que se vea en pantalla
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacidad ?? 1.0).cgColor ?? UIColor.black.cgColor)
                // Asigna el ancho del trazo en el contexto
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Point(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
         * guard:
         * Transfiere el control del programa fuera del alcance
         * cuando no se cumplen ciertas condiciones
         * Si la condición es true se la brinca y entra si es false
         */
        
        /*
         * Obtiene un objeto con la información del punto en la
         * pantalla que se tocó
         */
        guard let toque = touches.first?.location(in: nil) else {
            return
        }
        
        guard var ultimoP = lines.popLast() else {return}
        ultimoP.points?.append(toque)
        ultimoP.color = colorTrazo
        ultimoP.width = anchoTrazo
        ultimoP.opacidad = opacidadTrazo
        
        /*
         * Añade un punto al vector de puntos para que se dibuje
         */
        lines.append(ultimoP)
        setNeedsDisplay()
    }
    
    /*
     * Limpia el vector de puntos para borrar los dibujos
     */
    func clearCanvasView() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    /*
     * Elimina el último punto del vector para deshacer el último punto
     */
    func undoDraw() {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
}
