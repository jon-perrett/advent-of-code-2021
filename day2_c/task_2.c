#include "task_1.h"
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void increase_aim(Position* pos, int amount) {
    pos->aim = pos->aim + amount;
}

void increase_horiz(Position* pos, int amount) {
    pos->horizontal = pos->horizontal + amount;
}

void increase_depth(Position* pos, int amount) {
    pos->depth = pos->depth + amount*pos->aim;
}

int main(int argc, char *argv[])
{
    FILE * fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;
    Position current_position = {0, 0, 0};

    fp = fopen(argv[1], "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);
    int down_amount= 0;
    int up_amount=0;
    int forward_amount=0;
    
    while ((read = getline(&line, &len, fp)) != -1) {
        if (strstr(line, "down") != NULL) {
            down_amount = atoi(line + strlen(line) -2);
            increase_aim(&current_position, down_amount);
        
        } else if (strstr(line, "up") != NULL) {
            up_amount = -1 * atoi(line + strlen(line) -2);
            increase_aim(&current_position, up_amount);
            
        } else if (strstr(line, "forward") != NULL) {
            forward_amount = atoi(line + strlen(line) -2);
            increase_horiz(&current_position, forward_amount);
            increase_depth(&current_position, forward_amount);
        }
    }
    int answer = current_position.depth * current_position.horizontal;
    printf("Depth: %d\n", current_position.depth );
    printf("Horizontal: %d\n", current_position.horizontal);
    printf("Answer: %d\n", answer );
    
    fclose(fp);
    if (line)
        free(line);
    exit(EXIT_SUCCESS);
}