package queue.test;

import queue.Queue;
import queue.impl.LinkedListQueue;
import exceptions.EmptyQueueException;

public class QueueTest {

	/**
	 * @param args
	 * @throws EmptyQueueException 
	 */
	public static void main(String[] args) throws EmptyQueueException {
		Queue<Integer> queue=new LinkedListQueue<Integer>();
		queue.enqueue(1);
		queue.enqueue(2);
		queue.enqueue(3);
		System.out.println(queue.dequeue());
		System.out.println(queue.dequeue());
		System.out.println(queue.dequeue());
		queue.enqueue(4);
		queue.enqueue(5);
		queue.enqueue(6);
		System.out.println(queue.dequeue());
		System.out.println(queue.dequeue());
		System.out.println(queue.dequeue());
	}

}
