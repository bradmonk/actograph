# actograph
actograph is a matlab function for plotting circadian rhythm actograms


## Example figure
<a href="https://github.com/subroutines/actograph/blob/master/actograph.png?raw=true" target="_blank">
<img src="https://github.com/subroutines/actograph/blob/master/actograph.png?raw=true" width="800" border="10" /></a>
    actograph evoked with zero inputs generates & plots sample data

           >> actograph()
     
       you can save the simulated dataset to your workspace by:
     
           >> simData = actograph()
 
    actograph evoked with an arg plots *your* circadian rhythem data

           >> actograph(dataMx)
 
 Where dataMx is a data matrix structured such that each row
 represents your binned activity data **as you want it plotted**.
 Basically, WYSIWYG. Each value from the dataMx will be plotted
 as a bar in the actogram. Each row in the dataMx will be a new row
 in the actogram. So if, for example, you want 48 hours worth of data 
 plotted on the same row in the actogram, and the next 48 hours on the
 next row (and so on...) just put that 48 hours worth of data in the
 same row of the dataset you send to actograph. Try it out...


       >> actograph()

       >> actograph(repmat([1:24 1:24],[20 1]))

       >> days = 20; binsPerDay = 96
       >> actograph(rand(days, binsPerDay))
