#include <stdbool.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>
#include "mqueue.h"
#include "common.h"
#include <wait.h>

int spawn (char* program, char** arg_list)
{
	pid_t child_pid;
	/* Duplicate this process.  */
	child_pid = fork ();
	if (child_pid != 0)
	/* This is the parent process.  */
		return child_pid;
	else {
		/* Now execute PROGRAM, searching for it in the path.  */
		execvp (program, arg_list);
		/* The execvp function returns only if an error occurs.  */
		fprintf (stderr, "an error occurred in execvp\n");
		abort ();
	}
}

int 
main(int argc, char *argv[])
{
	mqd_t qdes;
	char  qname[] = "/herpderp";	//queue name must start with '/'. man mq_overview
	mode_t mode = S_IRUSR | S_IWUSR;
	struct mq_attr attr;
	
	struct timeval tv;	
	int max_num = 100;
	
	double start_time;
	double start_message_time;
	double end_time;

	if (argc < 3) {
		printf("Usage: %s <num produced> <num queue size>\n", argv[0]);
		exit (1);
	}

	int child_status;
	char* arg_list[] = { "./receiver.out", argv[1], argv[2], NULL };
	
	attr.mq_maxmsg  = atoi(argv[2]);
	attr.mq_msgsize = sizeof(max_num);
	attr.mq_flags   = 0;		// blocking queue 

	qdes  = mq_open(qname, O_RDWR | O_CREAT, mode, &attr);
	if (qdes == -1 ) {
		perror("mq_open() failed");
		exit(1);
	}

	srand(time(0));

	gettimeofday(&tv, NULL);
	start_time = tv.tv_sec + tv.tv_usec/1000000.0;
	
	//start the receiver
	spawn("./receiver.out", arg_list);
	
	gettimeofday(&tv, NULL);
	start_message_time = tv.tv_sec + tv.tv_usec/1000000.0;	

	int i;

	//loop through sending the messages	
	for (i = 0; i < atoi(argv[1]); i++) {
		int num = rand() % max_num;

		if (mq_send(qdes, (char *)&num, sizeof(max_num), 0) == -1) {
			perror("mq_send() failed");
		}
		//printf("Sending a random number %d\n", num);
	}

	if (mq_close(qdes) == -1) {
		perror("mq_close() failed");
		exit(2);
	}

	if (mq_unlink(qname) != 0) {
		perror("mq_unlink() failed");
		exit(3);
	}
	
	//wait to finish receiving messages
	wait(&child_status);

	if (WIFEXITED(child_status)) {			
		gettimeofday(&tv, NULL);
		end_time = tv.tv_sec + tv.tv_usec/1000000.0;

		printf("Time to initialize system: %f\n", start_message_time - start_time); 
		printf("Time to transmit data: %f\n", end_time - start_message_time); 
	} else {
		printf("Child process exited abnormally");
	}

	return 0;
}

