package semanticError;

import javax.xml.stream.Location;

public class CompileError extends RuntimeException {
    private String message;

    public CompileError(String stage, String msg, Location location) {
        assert location != null;
        this.message = StringProcess.getErrWarning
    }
}
