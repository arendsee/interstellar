# TODO
# 1) Add in more sophisticated death and fertility tables
# 2) Add event table (probabilities for mass deaths)
# 3) Add statistical overview table to each simulation

# Assume all people, regardless of sex, are indistinguishable
# Let X_i equal the probability that you survive year i given you survived to year i
# Let D = {X_1, ..., X_80}, that is, the yearly deathrate
# This function sets D
calculate.deathrate <- function(max.age){
    c(rep(0, max.age-1), 1)
}

# This function sets the yearly fertility rate, that is, the probability that a
# female of a certain age will have a child given there is a slot for one
calculate.fertility <- function(max.age, min.rep=20, max.rep=40, fertility=0.2){
    c(rep(0, min.rep), rep(fertility, max.rep), rep(0, max.age - min.rep - max.rep)) 
}

runsim_ <- function(max.pop=30, journey.time=100, max.age=80, ...){

    # person years for a trip
    py <- journey.time * max.pop

    # 0 for male, 1 for female
    sex <- matrix(rep(0, py), ncol=max.pop)
    sex[1, ] <- c(rep(1, ceiling(max.pop / 2)), rep(0, floor(max.pop / 2)))

    # Ages, from 0 to 80
    age <- matrix(rep(0, py), ncol=max.pop)
    # age[1, ] <- floor(seq(0, max.age, length.out=max.pop))
    age[1, ] <- ceiling(runif(max.pop, 0, max.age - 1))

    # Binary matrix stating whether individuals are alive (1) or dead (0)
    alive <- matrix(rep(0, py), ncol=max.pop)
    alive[1, ] <- rep(1, max.pop)

    # Rolls for life and death
    roll <- matrix(runif(py), ncol=max.pop)

    # Build death table according to input parameters
    death.table <- calculate.deathrate(max.age)

    # Build fertility versus age table
    fertility.table <- calculate.fertility(max.age, ...)

    for(i in 2:journey.time){
        # Copy and increment age
        age[i, ] <- age[i-1, ] + 1
        # Calculate survivors
        alive[i, ] <- alive[i-1, ] & roll[i, ] > death.table[age[i, ]]
        # Copy sex
        sex[i, ] <- sex[i-1, ]

        # Maximum possible births
        max.babies <- sum(sex[i, ] & alive[i, ] & roll[i, ] < fertility.table[age[i, ]])
        # Available life-slots
        life.slots <- which(alive[i, ] == 0)
        if(max.babies && length(life.slots) > 0){
            b <- min(max.babies, length(life.slots))
            age[i, life.slots[1:b]] <- 0
            sex[i, life.slots[1:b]] <- sample(c(1,0), b, replace=TRUE)
            alive[i, life.slots[1:b]] <- 1
        }
    }

    # Return the number of females
    rowSums(sex & alive)
}

run.simulation <- function(trials=1, ...){
    dat  <- c() 
    for(i in 1:trials){
        dat <- c(dat, runsim_(...)) 
    }
    sim <- data.frame(matrix(dat, ncol=trials))
    rownames(sim) <- 1:nrow(sim)
    colnames(sim) <- as.character(1:trials)
    sim
}

plot.simulation <- function(...){
    require(ggplot2)
    require(reshape2)
    dat <- run.simulation(...)
    m <- melt(dat, measure.vars=colnames(dat))
    colnames(m) <- c('trial', 'nfemales')
    m$year <- rep(1:nrow(dat), ncol(dat))
    ggplot(m) +
        geom_path(
            aes(
                x=year,
                y=nfemales,
                group=trial,
                color=trial
            )
        ) +
        theme(legend.position="none")
}
