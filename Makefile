# Build to `build`

SOURCE_DIR=msgs
OUTPUT_DIR=build

NS="ros::std_msgs"

RCGENMSG=rcgenmsg

SRCS=$(wildcard $(SOURCE_DIR)/*.msg)

OBJS=$(subst $(SOURCE_DIR),$(OUTPUT_DIR),$(SRCS:.msg=.capnp))

default: $(OBJS)

# Hide or not the calls depending of VERBOSE
ifeq ($(VERBOSE),TRUE)
    HIDE =  
else
    HIDE = @
endif

$(OUTPUT_DIR)/%.capnp: $(SOURCE_DIR)/%.msg
	$(HIDE)mkdir -p $(dir $@)
	$(HIDE)$(RCGENMSG) --namespace $(NS) $< > $@

.PHONY: clean default

clean:
	rm -r build/*