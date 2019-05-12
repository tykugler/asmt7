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

// HYDROGEN
// INPUTS: 	MSG, a channel for sending messages to the Waterlog process
//			DST, a channel for sending atoms to the Molecule process
// Hydrogen will generate H atoms every 200ms and send them to the Molecule
// process. It will also send a message to the Waterlog process to record
// the interaction.

func hydrogen(msg chan<- int, dst chan<- int) {
	i := 0
	for {
		msg <- i
	 	dst <- i
		i += 1
		 
		// Good work! Take a quick break :)
	 	time.Sleep(200 * time.Millisecond)
     }
}


// OXYGEN
// INPUTS: 	MSG, a channel for sending messages to the Waterlog process
//			DST, a channel for sending atoms to the Molecule process
// Oxygen will generate O atoms every 200ms and send them to the Molecule
// process. It will also send a message to the Waterlog process to record
// the interaction.

func oxygen(msg chan<- int, dst chan<- int) {
	i := 0
	for {
     	msg <- i
		dst <- i
		i += 1

		// Good work! Take a quick break :)
         	time.Sleep(200 * time.Millisecond)
     }
}


// MOLECULE
// INPUTS: 	HY1, a channel for atoms from the Hydrogen1 process
//			HY2, a channel for atoms from the Hydrogen2 process
//			OX, a channel for atoms from the Oxygen process
//			WATER, a channel for sending messages to the Waterlog process
// Molecule will select an atom from the Oxygen or Hydrogen processes and add 
// it to its internal count. Once it has >= 2 Hydrogen and >= 1 Oxygen, it will
// subtract those from its internal count and generate a water molecule. Then 
// it sends a message to the Waterlog process. 	

func molecule(hy1 <-chan int, hy2 <-chan int, ox <-chan int, water chan<- int) {
     
     w := 0
     h := 0
     o := 0
     for {
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
}


// WATERLOG
// INPUTS: 	HY1, a channel for messages from the Hydrogen1 process
//			HY2, a channel for messages from the Hydrogen2 process
//			OX, a channel for messages from the Oxygen process
//			WATER, a channel for messages from the Molecule process
// OUTPUT:	Waterlog will print a message every time it receives one
//			from one of the 4 processes creating atoms or molecules. 


func waterlog(hy1 <-chan int, hy2 <-chan int, ox <-chan int, water <-chan int) {
     h := 0
     for {
     	select {
			case m := <-hy1:
				fmt.Printf("Hydrogen1 has produced H atom #%d\n", m)
				h += 1
			
			case j := <-hy2:
				fmt.Printf("Hydrogen2 has produced H atom #%d\n", j)
				h += 1
				
			case k := <-ox:
				fmt.Printf("Oxygen has produced O atom #%d\n", k)

			case l := <-water:
				fmt.Printf("\n==> Water molecule #%d has been created!\n\n", l)
	 	}    
     }
}

// MAIN
// This function creates all of the channels and calls the 5 processes: two Hydrogens,
// one Oxygen, one Molecule, and one Waterlog to record every interaction. The first 4
// are called as goroutines to make them run concurrently. The last is called as a normal
// function so that the Main function doesn't finish too abruptly and cancel the other
// goroutines. 

func main() {

    hy1_msg := make(chan int)
    hy1_dest := make(chan int)
    hy2_msg := make(chan int)
    hy2_dest := make(chan int)
    ox_msg := make(chan int)
    ox_dest := make(chan int)
    water_msg := make(chan int)

    go oxygen(ox_msg, ox_dest)
    go hydrogen(hy1_msg, hy1_dest)
    go hydrogen(hy2_msg, hy2_dest)
    go molecule(hy1_dest, hy2_dest, ox_dest, water_msg)
    waterlog(hy1_msg, hy2_msg, ox_msg, water_msg)    
}

