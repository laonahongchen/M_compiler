package Mxstar.Backend;

import Mxstar.IR.Operand.VirReg;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.function.BiConsumer;

public class Graph {
    public HashMap<VirReg, HashSet<VirReg>> graph;

    public Graph() {
        graph = new HashMap<>();
    }
    public Graph(Graph g) {
        graph = new HashMap<>();
        for (VirReg virReg: g.getAllRegs())
            graph.put(virReg, new HashSet<>(g.getAdjacent(virReg)));
    }

    public HashSet<VirReg> getAdjacent(VirReg virReg) {
        return graph.getOrDefault(virReg, new HashSet<>());
    }
    public Collection<VirReg> getAllRegs() {
        return graph.keySet();
    }

    public void addRegister(VirReg virReg) {
        if (!graph.containsKey(virReg))
            graph.put(virReg, new HashSet<>());
    }

    public void addRegisters(Collection<VirReg> regs) {
        for (VirReg reg: regs){
            addRegister(reg);
        }
    }

    public void delReg(VirReg virReg) {
        for (VirReg reg: getAdjacent(virReg)) {
            graph.get(reg).remove(virReg);
        }
        graph.remove(virReg);
    }

    public void addEdge(VirReg a, VirReg b) {
        if (a == b)
            return ;
        graph.get(a).add(b);
        graph.get(b).add(a);
    }

    public void removeEdge(VirReg a, VirReg b) {
        if (graph.containsKey(a) && graph.get(a).contains(b)) {
            graph.get(a).remove(b);
            graph.get(b).remove(a);
        }
    }

    public void clear() {
        graph.clear();
    }

    public void forEach(BiConsumer<VirReg, VirReg> consumer ) {
        for (VirReg reg1: graph.keySet())
            for (VirReg reg2: graph.get(reg1)) {
                consumer.accept(reg1, reg2);
            }
    }

    public int getDeg(VirReg virReg) {
        return graph.get(virReg).size();
    }


}
