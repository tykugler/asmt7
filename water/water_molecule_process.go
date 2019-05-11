/*
 * CMPU-377 - Parallel Programming
 * Spring 2019
 *
 * water_molecule_process.go
 * Tyler Kugler
 *
 * This is a concurrent implementation of the water molecule problem.
 */

package main

import "fmt"
import "time"

// hydrogen

func hydrogen(msg chan<- int, dst chan<- int) {
     for i := 0; i < 50; i++ {
	 msg <- i
	 dst <- i
	 time.Sleep(100 * time.Millisecond)
     }
}


// oxygen 

func oxygen(msg chan<- int, dst chan<- int) {
     for i := 0; i < 50; i++ {
      	 msg <- i
         dst <- i
         time.Sleep(100 * time.Millisecond)
     }
}


// water molecule

func molecule(hy1 <-chan int, hy2 <-chan int, ox <-chan int, water chan<- int, kill chan<-  bool) {
     
     w := 0
     h := 0
     o := 0
     for i := 0; i < 150; i++ {
     	 select {
	 	case <-hy1:
		     h += 1
		case <-hy2:
		     h += 1
		case <-ox:
		     o += 1
	 }
	 
	 if h >= 2 && o >= 1 {
	    h = h - 2
	    o = o - 1
	    
	    water <- w
	    w += 1 
	 }
     }
     kill <- true
}


// waterlog 

func waterlog(hy1 <-chan int, hy2 <-chan int, ox <-chan int, water <-chan int, kill chan<- bool) {
     h := 0
     for i:= 0; i < 200; i++ {
     	 select {
	 	case m := <-hy1:
		     fmt.Printf("Hydrogen1 has produced its %d H atom\n", m)
		     h += 1
		
		case j := <-hy2:
		     fmt.Printf("Hydrogen2 has produced its %d H atom\n", j)
		     h += 1
                
		case k := <-ox:
		     fmt.Printf("Oxygen has produced its %d O atom\n", k)

		case l := <-water:
		     fmt.Printf("\n==> Water molecule %d has been created!\n\n", l)
	 }    
     }
     kill <- true
}


func main() {

    hy1_msg := make(chan int)
    hy1_dest := make(chan int)

    hy2_msg := make(chan int)
    hy2_dest := make(chan int)

    ox_msg := make(chan int)
    ox_dest := make(chan int)
    
    water_msg := make(chan int)

    kill1 := make(chan bool)
    kill2 := make(chan bool)

    go waterlog(hy1_msg, hy2_msg, ox_msg, water_msg, kill1)    
    go oxygen(ox_msg, ox_dest)
    go hydrogen(hy1_msg, hy1_dest)
    go hydrogen(hy2_msg, hy2_dest)
    go molecule(hy1_dest, hy2_dest, ox_dest, water_msg, kill2)
    
    for i := 0; i < 2; i++ {
    	select {
	       case <- kill1:
	       case <- kill2:
	}
    }

    fmt.Println("50 water molecules have been created!")
}

