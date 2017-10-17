package edu.rosehulman.zhaiz;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.pig.FilterFunc;
import org.apache.pig.FuncSpec;
import org.apache.pig.data.DataType;
import org.apache.pig.data.Tuple;
import org.apache.pig.impl.logicalLayer.FrontendException;
import org.apache.pig.impl.logicalLayer.schema.Schema;

public class IsGoodQuality extends FilterFunc {

	@Override
	public List<FuncSpec> getArgToFuncMapping() throws FrontendException{
		List<FuncSpec> funcSpecs = new ArrayList<FuncSpec>();
		// I am creating a new functional specification to add to my list. Each functional specification takes in
		// its constructor the name of the class and a schema definition. Since we are specifying a field, I am
		//constructing a field schema of type Integer and since Pig doesn't care about the name, I have it as null
		funcSpecs.add(new FuncSpec(this.getClass().getName(), 
				new Schema(new Schema.FieldSchema(null, DataType.INTEGER))));
		return funcSpecs;
	}

	@Override
	public Boolean exec(Tuple input) throws IOException {
		// TODO Auto-generated method stub
		if(input == null || input.size() == 0){
			return false;
		}
		Object val = input.get(0);
		if(val == null){
			return false;
		}
		int i = (Integer)val;
		
		return (i == 5 || i==9 || i==1 || i==4 || i==0);
	}

}
