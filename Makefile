
CC=gcc
CCFLAGS=
LDFLAGS=

SRC_DIR=src
BLD_DIR=build
OBJ_DIR=build/obj

TARGET=$(BLD_DIR)/test-app

SOURCES=$(SRC_DIR)/main.c

XOBJECTS=$(SOURCES:.c=.o)
OBJECTS=$(subst $(SRC_DIR),$(OBJ_DIR),$(XOBJECTS))

all: $(TARGET)

clean:
	rm -rf $(OBJ_DIR)
	rm -rf $(BLD_DIR)

docker-up:
	docker-compose -f docker/dev/docker-compose.yml up -d

docker-down:
	docker-compose -f docker/dev/docker-compose.yml stop
	docker-compose -f docker/dev/docker-compose.yml down

docker-build:
	docker exec test-test make -C /usr/local/src/test clean all

docker-restart:
	docker-compose -f docker/dev/docker-compose.yml restart

docker-logs:
	docker-compose -f docker/dev/docker-compose.yml logs

$(TARGET): $(BLD_DIR) $(OBJ_DIR) $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

$(BLD_DIR):
	mkdir -p $(BLD_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c $< $(CCFLAGS) -o $@
