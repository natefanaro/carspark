//
// Particle Electron remote car starter
// https://github.com/natefanaro/carspark
//
// To use, log in to https://build.particle.io and paste this in a new project
//

// Remote Buttons
const int pin_start = C0;
const int pin_lock = C1;
const int pin_unlock = C2;
const int pin_trunk = C3;

// Status LEDs
const int pin_led1 = D4;
const int pin_led2 = D5;
const int pin_led3 = D6; // not used yet
const int pin_led4 = D7; // not used yet

// inputs
const int pin_temp = A7;

// current temp
int temperature;
int tempSensorValue;

// This routine runs only once upon reset
void setup()
{
	// Sample call
	// curl https://api.particle.io/v1/devices/<device_id>/?access_token=<access_token>

	Particle.function("start", start);
	// curl https://api.particle.io/v1/devices/<device_id>/start -d access_token=<access_token>

	// Send 1 for lock, 0 for unlock
	Particle.function("door_lock", door_lock);
	// curl https://api.particle.io/v1/devices/<device_id>/door_lock -d "access_token=<access_token>&mode=0"
	// curl https://api.particle.io/v1/devices/<device_id>/door_lock -d "access_token=<access_token>&mode=1"

	// Required Options: panic, siren (not enabled yet since this is annoying, and I might not need this)
	// Particle.function("alarm", alarm);
	// curl https://api.particle.io/v1/devices/<device_id>/alarm -d "access_token=<access_token>&mode=panic"
	// curl https://api.particle.io/v1/devices/<device_id>/alarm -d "access_token=<access_token>&mode=alarm"

	// Required Options: 1,2
	Particle.function("aux", aux);
	// curl https://api.particle.io/v1/devices/<device_id>/aux -d "access_token=<access_token>&mode=1"
	// curl https://api.particle.io/v1/devices/<device_id>/aux -d "access_token=<access_token>&mode=2"

	// Past this point puts you past the four command limit of Particle.function if all above are enabled.

	// Required options: test, carcheck
	Particle.function("opt", opt);
	// curl https://api.particle.io/v1/devices/<device_id>/opt -d "access_token=<access_token>&mode=test"
	// curl https://api.particle.io/v1/devices/<device_id>/opt -d "access_token=<access_token>&mode=carcheck"
	// curl https://api.particle.io/v1/devices/<device_id>/opt -d "access_token=<access_token>&mode=valet"

	// Configure pins
	// Remote
	pinMode(pin_start, OUTPUT);
	pinMode(pin_lock, OUTPUT);
	pinMode(pin_unlock, OUTPUT);
	pinMode(pin_trunk, OUTPUT);

	// Status
	pinMode(pin_led1, OUTPUT);
	pinMode(pin_led2, OUTPUT);
	pinMode(pin_led3, OUTPUT);
	pinMode(pin_led4, OUTPUT);

	// Misc input

	// curl https://api.particle.io/v1/devices/<device_id>/temperature?access_token=<access_token>
	//Particle.variable("temperature", &temperature, INT);

	//pinMode(pin_temp, INPUT);
}

bool status_sent = false;
String lastAction = "";

void loop()
{
	tempSensorValue = analogRead(pin_temp);
	temperature = temp();

	if (Particle.connected()) {
		// blue for on
		//digitalWrite(pin_led4, HIGH);

		// red off
		//digitalWrite(pin_led1, LOW);

		if (lastAction.length()) {
			Particle.publish("action", lastAction);
			lastAction = "";
		}

		// Sending details of our connection
		if (!status_sent) {
			//Particle.publish("status", "Connection to Particle cloud established");
			//Particle.publish("status", "deviceID: " + Particle.deviceID());
			status_sent = true;
		}
	}
	else {
		// red on = error
		digitalWrite(pin_led1, HIGH);

		// blue off
		digitalWrite(pin_led4, LOW);

		status_sent = false;
	}

	delay(500);
}

float temp()
{
	// convert the reading to volts
	float volts = (tempSensorValue * 3.3) / 4095;

	// temp in C
	float temperature = (volts - 0.5) * 100;

	// °C to °F	Multiply by 9, then divide by 5, then add 32
	temperature = ((temperature * 9.0) / 5.0) + 32.0;

	return temperature;
}

// api options

int start(String mode)
{
	lastAction = "start";

	// write to the appropriate pin
	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_start, HIGH);
	delay(2500);
	digitalWrite(pin_start, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

int door_lock(String mode)
{
	if (mode.equals("1"))
	{
		return lock();
	}
	return unlock();
}

int alarm(String mode)
{
	if (mode.equals("panic"))
	{
		return panic();
	}
	if (mode.equals("siren"))
	{
		return siren();
	}
	return -404;
}

int aux(String mode)
{
	if (mode.equals("1"))
	{
		return aux_primary();
	}
	if (mode.equals("2"))
	{
		return aux_secondary();
	}
	return -404;
}

int opt(String mode)
{
	if (mode.equals("test"))
	{
		return test();
	}
	if (mode.equals("carcheck"))
	{
		return carcheck();
	}
	if (mode.equals("valet"))
	{
		return valet();
	}
	return -404;
}

// Helpers here

// door_lock

int lock()
{
	lastAction = "lock";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_lock, HIGH);
	delay(500);
	digitalWrite(pin_lock, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

int unlock()
{
	lastAction = "unlock";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_unlock, HIGH);
	delay(500);
	digitalWrite(pin_unlock, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

// alarm

int siren()
{
	lastAction = "siren";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_lock, HIGH);
	digitalWrite(pin_unlock, HIGH);
	delay(500);
	digitalWrite(pin_lock, LOW);
	digitalWrite(pin_unlock, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

int panic()
{
	lastAction = "panic";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_lock, HIGH);
	delay(3500);
	digitalWrite(pin_lock, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

// aux

int aux_primary()
{
	lastAction = "aux_primary";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_trunk, HIGH);
	delay(500);
	digitalWrite(pin_trunk, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

int aux_secondary()
{
	lastAction = "aux_secondary";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_start, HIGH);
	delay(500);
	digitalWrite(pin_start, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

// opt

int test()
{
	lastAction = "test";

	digitalWrite(pin_led1, HIGH);
	delay(500);
	digitalWrite(pin_led2, HIGH);
	delay(500);
	digitalWrite(pin_led1, LOW);
	delay(500);
	digitalWrite(pin_led2, LOW);

	// Reset
	status_sent = false;

	return 1;
}

int carcheck()
{
	lastAction = "carcheck";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_trunk, HIGH);
	digitalWrite(pin_start, HIGH);
	delay(2500);
	digitalWrite(pin_trunk, LOW);
	digitalWrite(pin_start, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}

int valet()
{
	lastAction = "valet";

	digitalWrite(pin_led1, HIGH);
	digitalWrite(pin_lock, HIGH);
	digitalWrite(pin_trunk, HIGH);
	delay(500);
	digitalWrite(pin_lock, LOW);
	digitalWrite(pin_trunk, LOW);
	digitalWrite(pin_led1, LOW);
	return 1;
}