import java.util.Calendar;
import java.io.*;

public aspect Logger {
	
	Calendar cal = Calendar.getInstance();
	File file = new File("log.txt");
	FileWriter sc = null;
    BufferedWriter bw = null;

    pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje despu�s de haber creado un usuario 
    	System.out.println("**** User created ****");
}
    
    pointcut transaction():execution(void moneyMake*(..));
    pointcut money():execution(void moneyWith*(..));
    
    
    after() : transaction(){
    	try {
    	sc=new FileWriter(file, true);
    	bw = new BufferedWriter(sc);
        bw.write("Transacción realizada - "+"Hora: "+cal.get(Calendar.HOUR_OF_DAY)+":"+cal.get(Calendar.MINUTE)+"\n");
        bw.close();}
    	catch(Exception e){
    		System.out.println("Error al producir la transacción");
    	}
    }
    
    after(): money(){
    	try {
    		sc=new FileWriter(file, true);
        	bw = new BufferedWriter(sc);
            bw.write("Retiro de dinero - "+"Hora: "+cal.get(Calendar.HOUR_OF_DAY)+":"+cal.get(Calendar.MINUTE)+"\n");
            bw.close();}
        	catch(Exception e){
        		System.out.println("Error al retirar dinero");
        	}
    	
    }



}