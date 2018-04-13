package de.twometer.protodesign.permissions;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileList<T> {

    private String path;
    private List<T> theList = null;

    public FileList(String path) {
        this.path = path;
    }

    public T get(int idx) {
        load();
        return theList.get(idx);
    }

    public void add(T t) {
        load();
        theList.add(t);
        save();
    }

    public void remove(T t) {
        load();
        theList.remove(t);
        save();
    }

    public boolean contains(T t) {
        load();
        return theList.contains(t);
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
        theList = new ArrayList<>();
        try {
            new File(path).createNewFile();
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(path)));
            String line;
            while ((line = reader.readLine()) != null) theList.add((T) line);
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
