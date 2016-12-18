import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.Line2D;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterJob;
public class Printer implements Printable {
  //--- Private instances declarations
  private final double INCH = 72;
  public PrinterJob printJob;
  /**
   * Constructor
   */
  public Printer() {
    //--- Create a printerJob object
    printJob = PrinterJob.getPrinterJob();
    //--- Set the printable class to this one since we
    //--- are implementing the Printable interface
    printJob.setPrintable(this);
  }
  public void StartPrinting()
  {
    //--- Show a print dialog to the user. If the user
    //--- click the print button, then print otherwise
    //--- cancel the print job
    // this.g2d = myImage;
    if (printJob.printDialog()) {
      try {
        printJob.print();
      }
      catch (Exception PrintException) {
        PrintException.printStackTrace();
      }
    }   
  }
  /**
   * Method: print
   * <p>
   *
   * This class is responsible for rendering a page using the provided
   * parameters. The result will be a grid where each cell will be half an
   * inch by half an inch.
   *
   * @param g
   *            a value of type Graphics
   * @param pageFormat
   *            a value of type PageFormat
   * @param page
   *            a value of type int
   * @return a value of type int
   */
  public int print(Graphics pg, PageFormat pageFormat, int page) {
    int i;
    Line2D.Double line = new Line2D.Double();
    Graphics2D g2d;
    //--- Validate the page number, we only print the first page
    if (page == 0) {  //--- Create a graphic2D object a set the default parameters
      g2d = (Graphics2D) pg;
      g2d.setColor(Color.black);
      //--- Translate the origin to be (0,0)
      g2d.translate(pageFormat.getWidth()/2-width/2, pageFormat.getWidth()/2);
      pg.drawImage(g.image, 0, 0, null);
      return (PAGE_EXISTS);
    }
    else
      return (NO_SUCH_PAGE);
  }
} // printerclass