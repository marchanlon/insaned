
PROJECT := insaned

CXXFLAGS := -Wall -Wextra -pedantic -pipe -O2 -std=c++11 -I/usr/local/include -Isrc $(CXXFLAGS)
LDFLAGS := -L/usr/local/lib $(LDFLAGS)


all : $(PROJECT)

$(PROJECT) : src/insaned.o src/InsaneDaemon.o src/InsaneException.o src/Timer.o
	$(CXX) $(CXXFLAGS) $^ $(LDFLAGS) -lsane -o $@

src/%.o : src/%.cpp src/%.h
	$(CXX) $(CXXFLAGS) -c $< -o $@


.PHONY : clean

clean :
	rm -rf src/*.o $(PROJECT)

debian : clean
	 dpkg-buildpackage -d -b -us -uc
	 # build debian package from sources (-b) on bullseye, -d is to skip dh-systemd error, which appears to be a stale dependency
