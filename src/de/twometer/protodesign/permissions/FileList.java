package de.twometer.protodesign.permissions;

import java.io.*;
import java.util.List;

public class FileList<T> {

    private String path;
    private List<T> theList = null;

    public FileList(String path) {
        this.path = path;
    }

    public T get(int idx) {
        ensureLoaded();
        return theList.get(idx);
    }

    public void add(T t) {
        ensureLoaded();
        theList.add(t);
        save();
    }

    public void remove(T t) {
        ensureLoaded();
        theList.remove(t);
        save();
    }

    public boolean contains(T t) {
        ensureLoaded();
        return theList.contains(t);
    }

    private void ensureLoaded() {
        if (theList == null)
            load();
    }

    private void save() {
        try {
            PrintStream stream = new PrintStream(new FileOutputStream(path));
            for (T t : theList) stream.println(String.valueOf(t));
            stream.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void load() {
        if (!new File(path).exists()) return;
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(path)));
            String line;
            while ((line = reader.readLine()) != null) theList.add((T) line);
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
